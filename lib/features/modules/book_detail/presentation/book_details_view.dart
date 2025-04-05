import 'package:book_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'controller/book_detail_bloc/book_detail_bloc.dart';
import '../../../presentation/components/circle_dot.dart';
import '../../../presentation/components/image_with_shimmer.dart';
import '../../../presentation/components/loading_indicator.dart';
import '../../../../core/resources/app_routes.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/domain/entities/book_detail.dart';
import '../../../../core/domain/enums/reading_status.dart';
import '../../../../core/firebase/models/shelf_item.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_values.dart';
import '../../../../core/utils/enum.dart';

/// View de detalhes do livro que mostra informações completas e opções
class BookDetailsView extends StatefulWidget {
  final String bookId;

  const BookDetailsView({super.key, required this.bookId});

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    super.initState();
    final bookDetailBloc = context.read<BookDetailBloc>();

    Future.microtask(() {
      bookDetailBloc.add(GetBookDetailEvent(widget.bookId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state.requestStatus == RequestStatus.loading) {
            return const LoadingIndicator();
          } else if (state.requestStatus == RequestStatus.loaded) {
            return BookDetailWidget(bookDetail: state.bookDetail!);
          } else {
            return const Center(
              child: Text('Não foi possível carregar os detalhes do livro'),
            );
          }
        },
      ),
    );
  }
}

class BookDetailWidget extends StatelessWidget {
  final BookDetail bookDetail;

  const BookDetailWidget({super.key, required this.bookDetail});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildBookImage(context, size),
                    _buildBookInfo(context, textTheme, size),
                  ],
                ),
                _buildBackButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookImage(BuildContext context, Size size) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: ImageWithShimmer(
              width: size.width * 0.5,
              height: size.height * 0.3,
              imageUrl: bookDetail.imageLinks.thumbnail,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => _showModal(context: context, item: bookDetail),
            child: _getMarkerIcon(bookDetail.readingStatus),
          ),
        ),
      ],
    );
  }

  Widget _getMarkerIcon(ReadingStatus? status) {
    if (status == null) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.white,
          size: 30,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.bookmark,
          color: getColorByReadStatus(bookDetail.readingStatus!),
          size: 30,
        ),
      );
    }
  }

  Widget _buildBookInfo(BuildContext context, TextTheme textTheme, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  bookDetail.title,
                  maxLines: 2,
                  style: textTheme.titleMedium,
                ),
                Text(
                  bookDetail.author.join(', '),
                  maxLines: 2,
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Divider(height: size.height * 0.01),
          _buildBookDetails(textTheme),
          Divider(height: size.height * 0.01),
          _buildSynopsis(context, textTheme, size, bookDetail),
        ],
      ),
    );
  }

  Widget _buildBookDetails(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: Text('${bookDetail.publisher} ${bookDetail.publisherYear()}',
                style: textTheme.bodyLarge),
          ),
          const CircleDot(),
          Flexible(
            flex: 3,
            child: Text('${bookDetail.totalPages} páginas',
                style: textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  Widget _buildSynopsis(BuildContext context, TextTheme textTheme, Size size,
      BookDetail bookDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p8,
              bottom: AppPadding.p12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sinopse:', style: textTheme.titleLarge),
                if (bookDetail.readingStatus != null) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.bookOptionsRoute,
                            pathParameters: {'bookId': bookDetail.id});
                      },
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.secondary,
                        size: 30,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          Text(bookDetail.description, style: textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12, left: AppPadding.p16, right: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: const Icon(
                Icons.arrow_back_sharp,
                color: AppColors.secondaryText,
                size: AppSize.s24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModal({required BuildContext context, required BookDetail item}) {
    final shelfItem = ShelfItem(
      bookId: item.id,
      imageUrl: item.imageLinks.thumbnail,
      pages: item.totalPages,
    );

    final bloc = context.read<BookDetailBloc>();

    showModalBottomSheet(
      context: context,
      builder: (ctx) => _buildBottomSheet(ctx, bloc, shelfItem),
    );
  }

  Widget _buildBottomSheet(
      BuildContext context, BookDetailBloc bloc, ShelfItem item) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildListTile(context, bloc, item, AppStrings.read, Icons.bookmark,
              AppColors.read, ReadingStatus.read),
          _buildListTile(context, bloc, item, AppStrings.reading,
              Icons.bookmark, AppColors.reading, ReadingStatus.reading),
          _buildListTile(context, bloc, item, AppStrings.wantToRead,
              Icons.bookmark, AppColors.wantToRead, ReadingStatus.wantToRead),
          _buildListTile(context, bloc, item, AppStrings.rereading,
              Icons.bookmark, AppColors.rereading, ReadingStatus.rereading),
          _buildListTile(context, bloc, item, AppStrings.abandoned,
              Icons.bookmark, AppColors.abandoned, ReadingStatus.abandoned),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    BookDetailBloc bloc,
    ShelfItem item,
    String title,
    IconData icon,
    Color color,
    ReadingStatus status,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: () {
        item.readingStatus = status;
        item.title = bookDetail.title;
        bloc.add(AddBookToShelfEvent(item));
        Navigator.pop(context);
      },
    );
  }
}
