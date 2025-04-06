import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_routes.dart';
import '../../config/app_values.dart';
import 'circle_dot.dart';
import 'image_with_shimmer.dart';

class VerticalListviewCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final List<String> author;
  final String thumbnail;
  final int totalPages;
  final String publisherDate;

  const VerticalListviewCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.thumbnail,
    required this.totalPages,
    required this.publisherDate,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.bookDetailRoute, pathParameters: {'bookId': id});
      },
      child: Container(
        height: AppSize.s130,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.p8,
                left: AppPadding.p8,
                bottom: AppPadding.p8,
                right: AppPadding.p14,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),
                child: ImageWithShimmer(
                  width: AppSize.s84,
                  height: double.infinity,
                  imageUrl: thumbnail,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p6,
                      ),
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                  if (author.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p6,
                      ),
                      child: Text(
                        author.join(', '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (publisherDate.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppPadding.p6,
                          ),
                          child: Text(
                            '2009',
                            style: textTheme.bodySmall,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: AppPadding.p6,
                          ),
                          child: CircleDot(),
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppPadding.p6,
                        ),
                        child: Text(
                          '$totalPages páginas',
                          style: textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
