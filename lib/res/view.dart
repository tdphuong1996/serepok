import 'package:flutter/cupertino.dart';
import 'package:serepok/res/AppThemes.dart';

Widget ImageNetwork(String url) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        decoration: BoxDecoration(color: MyColor.PRIMARY_COLOR.withAlpha(50)),
      );
    },
  );
}
