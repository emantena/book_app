import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/app_colors.dart';

class ImageWithShimmer extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;

  const ImageWithShimmer({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: height,
          color: AppColors.secondaryText,
        ),
      ),
      errorWidget: (_, __, ___) {
        return const Icon(
          Icons.error,
          color: AppColors.error,
        );
      },
    );
  }
}
