import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/core/constants/image_url_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatTitleWidget extends StatelessWidget {
  const ChatTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      ImageUrlConstants.aynaImageUrl,
                    ),
                  ),
                ),
              ),
              10.widthBox,
              Text(
                "Ayna",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ).expanded()
      ],
    );
  }
}
