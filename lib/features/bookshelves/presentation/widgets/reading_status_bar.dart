import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/app_strings.dart';
import '../../../../core/config/app_values.dart';
import '../../../../core/utils/functions.dart';
import '../../../../domain/entities/reading_status.dart';
import '../bloc/bookshelf_bloc.dart';

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

    if (index < 6) {
      context.read<BookshelfBloc>().add(LoadBooksByStatus(status));
    } else {
      // Notificar o componente pai para exibir as metas na mesma tela
      context.read<BookshelfBloc>().add(const ToggleReadingGoalVisibility());
    }
  }

  @override
  Widget build(BuildContext context) {
    const double spaceBetweenAnimateIcon = 18;
    const double iconSize = 32;

    // Removing the Center widget and simplifying the layout
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            _animateIcon(
              label: AppStrings.all,
              index: 0,
              readingStatus: null,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(null),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: AppStrings.read,
              index: 1,
              readingStatus: ReadingStatus.read,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(ReadingStatus.read),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: AppStrings.wantToRead,
              index: 2,
              readingStatus: ReadingStatus.wantToRead,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(ReadingStatus.wantToRead),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: AppStrings.reading,
              index: 3,
              readingStatus: ReadingStatus.reading,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(ReadingStatus.reading),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: AppStrings.rereading,
              index: 4,
              readingStatus: ReadingStatus.rereading,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(ReadingStatus.rereading),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: AppStrings.abandoned,
              index: 5,
              readingStatus: ReadingStatus.abandoned,
              icon: Icon(
                Icons.bookmark,
                size: iconSize,
                color: getColorByReadStatus(ReadingStatus.abandoned),
              ),
            ),
            const SizedBox(width: spaceBetweenAnimateIcon),
            _animateIcon(
              label: 'Meta de leitura',
              index: 6,
              readingStatus: null,
              icon: const Icon(
                Icons.bar_chart_sharp,
                size: iconSize,
                color: Color.fromARGB(255, 164, 193, 243),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animateIcon({
    required String label,
    required int index,
    required ReadingStatus? readingStatus,
    required Icon icon,
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
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(45),
        onTap: () => _toggleExpand(index, readingStatus),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            if (isExpanded)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
