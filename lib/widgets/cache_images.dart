import 'package:audition/resources/app_constants/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImages extends StatelessWidget {
  final String imagePath;
  const CacheImages({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imagePath,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Image(image: AssetImage(AppIcons.appLogo)),
      fadeInDuration: const Duration(seconds: 3),
    );
  }
}
