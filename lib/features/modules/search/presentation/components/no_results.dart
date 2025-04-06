import 'package:flutter/material.dart';

import '../../../../../core/network/api_constants.dart';

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
