import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_strings.dart';
import '../../../../../core/config/app_values.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../domain/entities/reading_status.dart';
import '../../../../../presentation/blocs/bookshelf/bookshelf_bloc.dart';

class ReadingStatusBar extends StatefulWidget {
  const ReadingStatusBar({super.key});

  @override
  State<ReadingStatusBar> createState() => _ReadingStatusBarState();
}

class _ReadingStatusBarState extends State<ReadingStatusBar> {
  int _expandedIndex = 0;

  void _toggleExpand(int index, ReadingStatus? status) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? -1 : index;
    });
    context.read<BookshelfBloc>().add(LoadBooksByStatus(status));
  }

  @override
  Widget build(BuildContext context) {
    const double spaceBetweenAnimateIcon = 18;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              iconColor: getColorByReadStatus(null),
              label: AppStrings.all,
              index: 0,
              readingStatus: null,
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
                iconColor: getColorByReadStatus(ReadingStatus.read), label: AppStrings.read, index: 1, readingStatus: ReadingStatus.read),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
                iconColor: getColorByReadStatus(ReadingStatus.wantToRead),
                label: AppStrings.wantToRead,
                index: 2,
                readingStatus: ReadingStatus.wantToRead),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
                iconColor: getColorByReadStatus(ReadingStatus.reading),
                label: AppStrings.reading,
                index: 3,
                readingStatus: ReadingStatus.reading),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
                iconColor: getColorByReadStatus(ReadingStatus.rereading),
                label: AppStrings.rereading,
                index: 4,
                readingStatus: ReadingStatus.rereading),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
                iconColor: getColorByReadStatus(ReadingStatus.abandoned),
                label: AppStrings.abandoned,
                index: 5,
                readingStatus: ReadingStatus.abandoned),
          ],
        ),
      ),
    );
  }

  Widget _animateIcon({
    required Color iconColor,
    required String label,
    required int index,
    required ReadingStatus? readingStatus,
  }) {
    bool isExpanded = _expandedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 180 : AppSize.s50,
      height: AppSize.s50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
        borderRadius: BorderRadius.circular(45),
      ),
      child: InkWell(
        onTap: () => _toggleExpand(index, readingStatus),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark,
              size: 32,
              color: iconColor,
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
