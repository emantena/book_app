import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/book_options/book_options_bloc.dart';
import '../../widgets/book_options_app_bar.dart';
import '../../widgets/book_options_main_view.dart';
import '../../../../../core/utils/enum_types.dart';
import '../../../../../core/ui/components/loading_indicator.dart';
import '../../../../../core/config/app_routes.dart';

class BookOptionsView extends StatefulWidget {
  final String bookId;

  const BookOptionsView({
    super.key,
    required this.bookId,
  });

  @override
  State<BookOptionsView> createState() => _BookOptionsViewState();
}

class _BookOptionsViewState extends State<BookOptionsView> {
  @override
  void initState() {
    super.initState();
    final bookOptionsBloc = context.read<BookOptionsBloc>();

    Future.microtask(() {
      bookOptionsBloc.add(LoadBookEvent(widget.bookId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookOptionsAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BookOptionsBloc, BookOptionsState>(
            listenWhen: (previous, current) =>
                current.requestStatus == RequestStatus.error,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Ocorreu um erro'),
                    backgroundColor: Colors.red,
                  ),
                );
            },
          ),
          BlocListener<BookOptionsBloc, BookOptionsState>(
            listenWhen: (previous, current) =>
                current.operationType == OperationType.removeBook &&
                current.requestStatus == RequestStatus.loaded,
            listener: (context, state) {
              context.goNamed(
                AppRoutes.bookshelveRoute,
                extra: {'refresh': true},
              );
            },
          ),
        ],
        child: BlocBuilder<BookOptionsBloc, BookOptionsState>(
          builder: (context, state) {
            switch (state.requestStatus) {
              case RequestStatus.initial:
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
              case RequestStatus.error:
                if (state.bookItem == null) {
                  return const LoadingIndicator();
                }
                return BookOptionsMainView(bookItem: state.bookItem!);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
