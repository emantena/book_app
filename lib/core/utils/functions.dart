import 'dart:ui';

import '../../domain/entities/reading_status.dart';
import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../network/api_constants.dart';

String getImageWithoutCurl(String? imageLinks) {
  if (imageLinks == null || imageLinks == '') {
    return ApiConstants.noImage;
  }
  return imageLinks.replaceFirst('&edge=curl', '');
}

String removeAllHtmlTags(String htmlText) {
  if (htmlText.isEmpty) {
    return '';
  }

  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

Color getColorByReadStatus(ReadingStatus? status) {
  switch (status) {
    case ReadingStatus.read:
      return AppColors.read;
    case ReadingStatus.wantToRead:
      return AppColors.wantToRead;
    case ReadingStatus.reading:
      return AppColors.reading;
    case ReadingStatus.rereading:
      return AppColors.rereading;
    case ReadingStatus.abandoned:
      return AppColors.abandoned;
    default:
      return AppColors.all;
  }
}

String getTextByReadStatus(ReadingStatus? status) {
  switch (status) {
    case ReadingStatus.read:
      return AppStrings.read;
    case ReadingStatus.wantToRead:
      return AppStrings.wantToRead;
    case ReadingStatus.reading:
      return AppStrings.reading;
    case ReadingStatus.rereading:
      return AppStrings.rereading;
    case ReadingStatus.abandoned:
      return AppStrings.abandoned;
    default:
      return AppStrings.all;
  }
}
