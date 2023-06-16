import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileImageShimmer(double? radius) {
  return Shimmer.fromColors(
    baseColor: const Color(0xFF707070),
    highlightColor: const Color(0xFF8c8c8c),
    child: CircleAvatar(
      radius: radius,
    ),
  );
}
