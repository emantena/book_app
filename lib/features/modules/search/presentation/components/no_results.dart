import 'package:book_app/core/data/network/api_constants.dart';
import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Center(
        child: Image(
          image: NetworkImage(ApiConstants.notFound),
          width: size.width * 0.6,
          height: size.height * 0.6,
        ),
      ),
    );
  }
}
