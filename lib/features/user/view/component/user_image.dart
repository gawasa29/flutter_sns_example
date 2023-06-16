import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_example/common/utils/shimmer.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    required this.profilePic,
    required this.radius,
    super.key,
  });
  final String profilePic;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: CachedNetworkImage(
        imageUrl: profilePic,
        placeholder: (context, url) => profileImageShimmer(radius),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: radius,
        ),
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
          radius: radius,
        ),
      ),
    );
  }
}
