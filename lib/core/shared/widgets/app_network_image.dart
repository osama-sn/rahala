import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_loading.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: AppLoading(size: 24),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.surface,
          child: const Icon(Icons.error_outline),
        ),
      ),
    );
  }
}
