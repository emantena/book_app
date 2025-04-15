import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/ui/components/daily_reading_goal_card.dart';
import '../../../../core/ui/routes/app_routes.dart';
import '../../../../core/config/app_values.dart';
import '../../../../core/ui/components/image_with_shimmer.dart';
import '../../../../core/ui/components/read_indicator.dart';
import '../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../../../books/presentation/blocs/yearly_goals/yearly_goals_bloc.dart';
import '../../../bookshelves/presentation/bloc/bookshelf_bloc.dart';
import '../../../profile/presentation/bloc/profile_cubit.dart';
import '../widgets/discovery_card.dart';
import '../widgets/home_section_title.dart';
import '../widgets/quick_stats_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    final bookshelfBloc = context.read<BookshelfBloc>();
    final yearlyGoalsBloc = context.read<YearlyGoalsBloc>();

    Future.microtask(() {
      bookshelfBloc.add(const LoadBooksByStatus(null));
      yearlyGoalsBloc.add(LoadBooksByYearEvent(DateTime.now().year));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<BookshelfBloc>().add(const LoadBooksByStatus(null));
            context
                .read<YearlyGoalsBloc>()
                .add(LoadBooksByYearEvent(DateTime.now().year));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  const SizedBox(height: AppSize.s24),
                  _buildCurrentlyReadingSection(),
                  const SizedBox(height: AppSize.s24),
                  const HomeSectionTitle(title: 'Meta diária'),
                  const SizedBox(height: AppSize.s16),
                  const DailyReadingGoalCard(),
                  const SizedBox(height: AppSize.s24),
                  _buildQuickStatsSection(),
                  const SizedBox(height: AppSize.s24),
                  _buildReadingGoalsSection(),
                  const SizedBox(height: AppSize.s24),
                  _buildDiscoverBooksSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Obtenha o nome do usuário do estado
        final userName = state.user?.name ?? 'leitor';

        // Formate o nome para mostrar apenas o primeiro nome
        final firstName = userName.split(' ').first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $firstName!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            const Text(
              'Que tal ler um pouco hoje?',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentlyReadingSection() {
    return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, state) {
        if (state.bookshelf.books.isEmpty) {
          return _buildEmptyCurrentlyReading();
        }

        // Filtra apenas livros que estão sendo lidos
        final readingBooks = state.bookshelf.books
            .where((book) => book.readingStatus == ReadingStatus.reading)
            .toList();

        if (readingBooks.isEmpty) {
          return _buildEmptyCurrentlyReading();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionTitle(title: 'Continuando a leitura...'),
            const SizedBox(height: AppSize.s16),
            ...readingBooks.take(2).map((book) => _buildReadingBookCard(book)),
          ],
        );
      },
    );
  }

  Widget _buildEmptyCurrentlyReading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeSectionTitle(title: 'Continuando a leitura...'),
        const SizedBox(height: AppSize.s16),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.searchRoute),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(AppSize.s12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comece uma nova leitura',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      SizedBox(height: AppSize.s8),
                      Text(
                        'Pesquise e adicione livros à sua estante',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingBookCard(ShelfItemDto book) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.bookOptionsRoute,
        pathParameters: {'bookId': book.bookId},
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSize.s16),
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(AppSize.s12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                width: 80,
                height: 120,
                imageUrl: book.imageUrl,
              ),
            ),
            const SizedBox(width: AppSize.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: AppSize.s8),
                  ReadIndicator(
                    totalPagesToRead: book.pages,
                    totalReadPages: book.currentPage,
                  ),
                  const SizedBox(height: AppSize.s8),
                  Row(
                    children: [
                      const Icon(
                        Icons.book,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: AppSize.s4),
                      Text(
                        '${book.currentPage} de ${book.pages} páginas',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsSection() {
    return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, state) {
        int totalBooks = state.bookshelf.books.length;
        int readBooks = state.bookshelf.books
            .where((book) => book.readingStatus == ReadingStatus.read)
            .length;
        int pagesRead = state.bookshelf.pagesRead;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionTitle(title: 'Suas estatísticas'),
            const SizedBox(height: AppSize.s16),
            Row(
              children: [
                Expanded(
                  child: QuickStatsCard(
                    title: 'Livros lidos',
                    value: readBooks.toString(),
                    icon: Icons.check_circle_outline,
                    color: AppColors.read,
                  ),
                ),
                const SizedBox(width: AppSize.s12),
                Expanded(
                  child: QuickStatsCard(
                    title: 'Na estante',
                    value: totalBooks.toString(),
                    icon: Icons.shelves,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSize.s12),
                Expanded(
                  child: QuickStatsCard(
                    title: 'Páginas lidas',
                    value: pagesRead.toString(),
                    icon: Icons.menu_book,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildReadingGoalsSection() {
    return BlocBuilder<YearlyGoalsBloc, YearlyGoalsState>(
      builder: (context, state) {
        if (state.books.isEmpty) {
          return _buildEmptyReadingGoals();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HomeSectionTitle(title: 'Metas de leitura'),
                TextButton(
                  onPressed: () =>
                      context.pushNamed(AppRoutes.yearlyGoalsRoute),
                  child: const Text(
                    'Ver todas',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.books.length > 5 ? 5 : state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return GestureDetector(
                    onTap: () => context.pushNamed(
                      AppRoutes.bookOptionsRoute,
                      pathParameters: {'bookId': book.bookId},
                    ),
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: AppSize.s16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            child: ImageWithShimmer(
                              width: 120,
                              height: 160,
                              imageUrl: book.imageUrl,
                            ),
                          ),
                          const SizedBox(height: AppSize.s8),
                          Text(
                            book.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyReadingGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HomeSectionTitle(title: 'Metas de leitura'),
            TextButton(
              onPressed: () => context.pushNamed(AppRoutes.yearlyGoalsRoute),
              child: const Text(
                'Definir metas',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s16),
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 40,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSize.s16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Defina suas metas de leitura',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    SizedBox(height: AppSize.s4),
                    Text(
                      'Organize seus livros por ano e acompanhe seu progresso',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverBooksSection() {
    // Exemplos de categorias de descoberta
    final List<Map<String, dynamic>> categories = [
      {'name': 'Romance', 'icon': Icons.favorite, 'color': Colors.red},
      {'name': 'Ficção Científica', 'icon': Icons.rocket, 'color': Colors.blue},
      {'name': 'Fantasia', 'icon': Icons.auto_awesome, 'color': Colors.purple},
      {'name': 'História', 'icon': Icons.history_edu, 'color': Colors.brown},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeSectionTitle(title: 'Descubra novos livros'),
        const SizedBox(height: AppSize.s16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.searchRoute);
                },
                child: DiscoveryCard(
                  title: categories[index]['name'],
                  icon: categories[index]['icon'],
                  color: categories[index]['color'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
