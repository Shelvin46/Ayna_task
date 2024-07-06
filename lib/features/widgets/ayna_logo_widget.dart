import 'package:ayna_task/core/constants/image_url_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AynaLogoWidget extends StatelessWidget {
  const AynaLogoWidget({super.key, this.height = 150, this.width = 150});

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: ImageUrlConstants.aynaImageUrl,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
