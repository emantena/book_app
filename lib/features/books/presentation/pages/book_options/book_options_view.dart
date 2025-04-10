import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/book_options/book_options_bloc.dart';
import '../../widgets/book_options_app_bar.dart';
import '../../widgets/book_options_main_view.dart';
import '../../../../../core/utils/enum_types.dart';
import '../../../../../core/ui/components/loading_indicator.dart';

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
      body: BlocListener<BookOptionsBloc, BookOptionsState>(
        listener: (context, state) {
          if (state.requestStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Ocorreu um erro'),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<BookOptionsBloc, BookOptionsState>(
          builder: (context, state) {
            switch (state.requestStatus) {
              case RequestStatus.initial:
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
              case RequestStatus.error:
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
