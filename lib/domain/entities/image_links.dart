import 'package:book_app/core/utils/functions.dart';
import 'package:equatable/equatable.dart';

import '../../core/network/api_constants.dart';

class ImageLinks extends Equatable {
  final String smallThumbnail;
  final String thumbnail;
  final String small;
  final String medium;
  final String large;
  final String extraLarge;

  const ImageLinks({
    this.smallThumbnail = '',
    this.thumbnail = '',
    this.small = '',
    this.medium = '',
    this.large = '',
    this.extraLarge = '',
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      smallThumbnail: getImageWithoutCurl(json['smallThumbnail']),
      thumbnail: getImageWithoutCurl(json['thumbnail']),
      small: getImageWithoutCurl(json['small']),
      medium: getImageWithoutCurl(json['medium']),
      large: getImageWithoutCurl(json['large']),
      extraLarge: getImageWithoutCurl(json['extraLarge']),
    );
  }

  String getImageUrl() {
    if (extraLarge != '') {
      return extraLarge;
    } else if (large != '') {
      return large;
    } else if (medium != '') {
      return medium;
    } else if (small != '') {
      return small;
    } else if (thumbnail != '') {
      return thumbnail;
    } else if (smallThumbnail != '') {
      return smallThumbnail;
    }

    return ApiConstants.noImage;
  }

  @override
  List<Object?> get props => [smallThumbnail, thumbnail];
}
