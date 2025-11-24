import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constants.dart';

class MyCacheNetworkImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final bool keepSize;
  final Color? placeHolderColor;
  final Widget? placeholderWidget;
  final BlendMode? blendMode;
  final Color? blendModeColor;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;
  final bool viewInFullScreen;
  final double? aspectRatio;
  final bool isSkeleton;

  const MyCacheNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.progressIndicatorBuilder,
    this.borderRadius,
    this.keepSize = true,
    this.placeHolderColor,
    this.placeholderWidget,
    this.blendMode,
    this.blendModeColor,
    this.viewInFullScreen = false,
    this.aspectRatio,
    this.isSkeleton = false,
  });

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? _buildPlaceholder() // Show placeholder if URL is empty
        : viewInFullScreen
            ? _buildFullScreenView()
            : CacheImage(
                borderRadius: borderRadius,
                url: url,
                height: height,
                width: width,
                blendModeColor: blendModeColor,
                blendMode: blendMode,
                progressIndicatorBuilder: progressIndicatorBuilder ??
                    (context, url, progress) => Center(
                          child: CircularProgressIndicator(value: progress.progress),
                        ), // Show loading indicator while image loads
                fit: fit ?? BoxFit.cover,
              );
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        height: height ?? 100, // Provide a default height
        width: width ?? double.infinity, // Stretch to full width
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          color: Colors.transparent,
        ),
        child: Center(
          child: placeholderWidget ??
              Image.asset(
                'assets/logo/logo.png',
                fit: BoxFit.contain,
                height: height != null ? height! * 0.7 : 80, // Use a safe default size
                width: width != null ? width! * 0.7 : 80,
              ),
        ),
      ),
    );
  }

  Widget _buildFullScreenView() {
    return Scaffold(
      appBar: AppBar(),
      body: InteractiveViewer(
        child: CacheImage(
          borderRadius: borderRadius,
          url: url,
          height: double.infinity,
          width: double.infinity,
          blendModeColor: blendModeColor,
          blendMode: blendMode,
          progressIndicatorBuilder: progressIndicatorBuilder ??
              (context, url, progress) => Center(
                    child: CircularProgressIndicator(value: progress.progress),
                  ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.borderRadius,
    required this.url,
    required this.height,
    required this.width,
    required this.blendModeColor,
    required this.blendMode,
    required this.progressIndicatorBuilder,
    this.fallbackUrl = '${AppConstants.baseUrl}/img/placeholder.jpg',
    required this.fit,
  });

  final BorderRadiusGeometry? borderRadius;
  final String url;
  final double? height;
  final double? width;
  final Color? blendModeColor;
  final BlendMode? blendMode;
  final String fallbackUrl;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      cacheKey: url,
      color: blendModeColor,
      colorBlendMode: blendMode ?? BlendMode.darken,
      errorWidget: (context, url, error) => _buildErrorWidget(),
      fit: fit ?? BoxFit.cover,
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[300],
      height: height ?? 100,
      width: width ?? double.infinity,
      child: Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 40),
      ),
    );
  }
}
