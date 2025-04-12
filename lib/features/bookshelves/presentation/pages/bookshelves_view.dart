import 'package:book_app/core/config/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bookshelf_bloc.dart';
import '../widgets/reading_goal_card.dart';
import '../widgets/reading_status_bar.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/enum_types.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../data/models/dto/book_shelf_dto.dart';
import '../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../../../../core/ui/components/loading_indicator.dart';
import '../../../../core/ui/components/image_with_shimmer.dart';

class BookShelveView extends StatefulWidget {
  const BookShelveView({super.key});

  @override
  BookShelveViewState createState() => BookShelveViewState();
}

class BookShelveViewState extends State<BookShelveView> {
  int totalPages = 0;
  bool update = false;
  BookShelfDto? bookShelfDto;
  bool _needsRefresh = false;

  @override
  void initState() {
    super.initState();
    _loadBookshelfData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final GoRouterState goState = GoRouterState.of(context);
    final Map<String, dynamic>? extras = goState.extra as Map<String, dynamic>?;

    if (extras != null && extras['refresh'] == true && !_needsRefresh) {
      _needsRefresh = true;

      setState(() {
        update = false;
      });

      Future.microtask(() async {
        await _loadBookshelfData();
      });
    }
  }

  Future<void> _loadBookshelfData() async {
    final bookshelfBloc = context.read<BookshelfBloc>();
    bookshelfBloc.add(const LoadBooksByStatus(null));
    _needsRefresh = false;
  }

  void _updateTotalPages(BookShelfDto bookShelfDto) {
    // if (!update) {
    Future.microtask(() {
      setState(() {
        totalPages = bookShelfDto.pagesRead;
        update = true;
      });
    });
    // }
  }

  int getBooksByStatus(List<ShelfItemDto> books, ReadingStatus status) {
    final totalBooks = books.where((book) => book.readingStatus == status).length;
    return totalBooks;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Minha Estante",
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu_book_outlined,
                color: AppColors.primary,
              ),
              tooltip: 'Metas de leitura',
              onSelected: (String value) {
                if (value == 'yearlyGoals') {
                  context.pushNamed(AppRoutes.yearlyGoalsRoute);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'yearlyGoals',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('Metas anuais de leitura'),
                    ],
                  ),
                ),
                // Você pode adicionar mais opções de metas aqui no futuro
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: AppSize.s45),
            _resumeCard(context, totalPages),
            const SizedBox(height: 20),
            const ReadingStatusBar(),
            const SizedBox(height: 25),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await _loadBookshelfData();
                },
                child: BlocBuilder<BookshelfBloc, BookshelfState>(
                  builder: (context, state) {
                    if (state.requestStatus == RequestStatus.loading) {
                      return const Center(child: LoadingIndicator());
                    } else if (state.requestStatus == RequestStatus.loaded) {
                      _updateTotalPages(state.bookshelf);

                      if (state.showReadingGoal) {
                        return Column(
                          children: [
                            ReadingGoalCard(books: state.bookshelf.books),
                            const SizedBox(height: 20),
                            Expanded(
                              child: _buildBookGrid(context, state.bookshelf),
                            ),
                          ],
                        );
                      } else {
                        _updateTotalPages(state.bookshelf);
                        return _buildBookGrid(context, state.bookshelf);
                      }
                    } else {
                      return const Center(
                        child: Text('Não foi possível carregar a estante'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookGrid(BuildContext context, BookShelfDto bookshelf) {
    if (bookshelf.books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              "Sua estante está vazia",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Adicione livros através da busca",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                context.goNamed(AppRoutes.searchRoute);
              },
              child: const Text(
                "Buscar Livros",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        key: ValueKey<int>(bookshelf.books.length),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
        ),
        itemCount: bookshelf.books.length,
        itemBuilder: (context, index) {
          final book = bookshelf.books[index];
          return AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300 + (index * 50)),
            curve: Curves.easeInOut,
            child: _buildBookItem(context, book),
          );
        },
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, ShelfItemDto book) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => context.pushNamed(
          AppRoutes.bookOptionsRoute,
          pathParameters: {'bookId': book.bookId},
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.inactiveColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ImageWithShimmer(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: book.imageUrl,
                ),
              ),
              // Gradiente sutil para garantir que o ícone seja visível mesmo em capas claras
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.bookmark,
                    size: 24,
                    color: getColorByReadStatus(book.readingStatus),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resumeCard(BuildContext context, int totalPages) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.menu_book_rounded,
              color: AppColors.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              '$totalPages',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "páginas lidas",
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
