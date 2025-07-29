import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageViewer extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit? fit;

  const ImageViewer({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  width: 1.sw,
                  height: 400.h,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    maxHeightDiskCache: 400,
                    maxWidthDiskCache: 400,
                    memCacheHeight: 400,
                    memCacheWidth: 400,
                    imageUrl: imageUrl ?? '',
                    // errorWidget: (context, url, error) =>
                    //     AppAssets.images.logoPrimary.image(),
                    // placeholder: (context, url) =>
                    //     AppAssets.images.orderTest.image(),
                  ),
                ),
              );
            });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: imageUrl ?? '',
          maxHeightDiskCache: 400,
          maxWidthDiskCache: 400,
          memCacheHeight: 400,
          memCacheWidth: 400,
          fit: fit,
          // errorWidget: (context, url, error) =>
          //     AppAssets.images.logoPrimary.image(),
          // placeholder: (context, url) => AppAssets.images.orderTest.image(),
        ),
      ),
    );
  }
}
