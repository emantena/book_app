import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/ui/components/image_with_shimmer.dart';
import '../../../../core/ui/components/loading_indicator.dart';
import '../../../../core/utils/enum_types.dart';
import '../../../../core/utils/functions.dart';
import '../../../../data/models/dto/book_shelf_dto.dart';
import '../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../widgets/reading_status_bar.dart';
import '../bloc/bookshelf_bloc.dart';

class BookShelveView extends StatefulWidget {
  const BookShelveView({super.key});

  @override
  BookShelveViewState createState() => BookShelveViewState();
}

class BookShelveViewState extends State<BookShelveView> {
  int totalPages = 0;
  bool update = false;
  BookShelfDto? bookShelfDto;

  @override
  void initState() {
    super.initState();

    final bookshelfBloc = context.read<BookshelfBloc>();

    Future.microtask(() {
      bookshelfBloc.add(const LoadBooksByStatus(null));
    });
  }

  void _updateTotalPages(BookShelfDto bookShelfDto) {
    if (!update) {
      Future.microtask(() {
        setState(() {
          totalPages = bookShelfDto.pagesRead;
          update = true;
        });
      });
    }
  }

  int getBooksByStatus(List<ShelfItemDto> books, ReadingStatus status) {
    final totalBooks = books.where((book) => book.readingStatus == status).length;
    return totalBooks;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            _resumeCard(context, totalPages),
            const SizedBox(height: 20),
            const ReadingStatusBar(),
            const SizedBox(height: 25),
            const Divider(
              height: 2,
              color: AppColors.secondaryText,
            ),
            Expanded(
              child: BlocBuilder<BookshelfBloc, BookshelfState>(
                builder: (context, state) {
                  if (state.requestStatus == RequestStatus.loading) {
                    return const Center(child: LoadingIndicator());
                  } else if (state.requestStatus == RequestStatus.loaded) {
                    _updateTotalPages(state.bookshelf);
                    return _buildBookGrid(context, state.bookshelf);
                  } else {
                    return const Center(
                      child: Text('Não foi possível carregar a estante'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookGrid(BuildContext context, BookShelfDto bookshelf) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.7,
      ),
      itemCount: bookshelf.books.length,
      itemBuilder: (context, index) {
        final book = bookshelf.books[index];
        return _buildBookItem(context, book);
      },
    );
  }

  Widget _buildBookItem(BuildContext context, ShelfItemDto book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => context.pushNamed(
          AppRoutes.bookDetailRoute,
          pathParameters: {'bookId': book.bookId},
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.inactiveColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: ImageWithShimmer(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: book.imageUrl,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.bookmark,
                    size: 32,
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$totalPages',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "páginas lidas",
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
