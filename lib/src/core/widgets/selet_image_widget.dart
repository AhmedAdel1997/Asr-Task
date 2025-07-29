// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
// import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../config/language/locale_keys.g.dart';
// import '../../config/res/assets.gen.dart';
// import '../../config/res/color_manager.dart';
// import '../shared/base_state.dart';

// class SeletImageWidget extends StatelessWidget {
//   final BaseStatus status;
//   final double progressValue;
//   final File? image;
//   final String? currentImage;
//   final Function() onSuccess;

//   const SeletImageWidget({
//     super.key,
//     required this.status,
//     required this.progressValue,
//     required this.image,
//     required this.currentImage,
//     required this.onSuccess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DottedBorder(
//       borderType: BorderType.RRect,
//       dashPattern: const [4, 5],
//       radius: Radius.circular(8.r),
//       color: AppColors.primary,
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(8.r)),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//           height: 50.h,
//           width: 1.sw,
//           color: AppColors.white,
//           child: Row(
//             children: [
//               if (currentImage != null)
//                 CachedNetworkImage(
//                   imageUrl: currentImage!,
//                   height: 35.h,
//                   width: 30.w,
//                   maxHeightDiskCache: 400,
//                   maxWidthDiskCache: 400,
//                   memCacheHeight: 400,
//                   memCacheWidth: 400,
//                   fit: BoxFit.fill,
//                   placeholder: (context, url) {
//                     return const Icon(Icons.error);
//                   },
//                 ),
//               8.szW,
//               progressValue == 1.0
//                   ? AppAssets.svg.done.svg(color: AppColors.primary)
//                   : AppAssets.svg.upload.svg(),
//               8.szW,
//               Expanded(
//                 child: status == BaseStatus.loading
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (image != null)
//                             SizedBox(
//                               width: 100.w,
//                               child: Text(
//                                 image!.path.split('/').last,
//                                 maxLines: 1,
//                                 style: const TextStyle()
//                                     .s6
//                                     .setBlackColor
//                                     .setFontFamily
//                                     .medium,
//                               ),
//                             ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: LinearProgressIndicator(
//                                   value: progressValue,
//                                   semanticsValue: progressValue.toString(),
//                                   color: Colors.blue,
//                                   valueColor:
//                                       const AlwaysStoppedAnimation<Color>(
//                                     AppColors.primary,
//                                   ),
//                                 ),
//                               ),
//                               8.szW,
//                               Text(
//                                 ('${(progressValue * 100).toStringAsFixed(0)} %')
//                                     .toString(),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             LocaleKeys.uploadFileHere,
//                             maxLines: 1,
//                             style: const TextStyle()
//                                 .medium
//                                 .setPrimaryColor
//                                 .s12
//                                 .setFontFamily,
//                           ),
//                           2.szH,
//                           Text(
//                             '1 ميجا بحد أقصى | PDF, PNG',
//                             style: const TextStyle()
//                                 .setFontFamily
//                                 .s10
//                                 .medium
//                                 .setBlackColor,
//                           )
//                         ],
//                       ),
//               ),
//               8.szW,
//               image == null
//                   ? GestureDetector(
//                       onTap: onSuccess,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.white,
//                           border: Border.all(color: AppColors.black),
//                           borderRadius: BorderRadius.circular(4.r),
//                         ),
//                         padding: EdgeInsets.all(4.w),
//                         child: Row(
//                           children: [
//                             Text(
//                               LocaleKeys.browse,
//                               style: const TextStyle()
//                                   .setBlackColor
//                                   .s10
//                                   .setFontFamily,
//                             ),
//                             4.szW,
//                             AppAssets.svg.uploadFile.svg(),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Row(
//                       children: [
//                         Image.file(
//                           image!,
//                           height: 35.h,
//                           width: 30.w,
//                           fit: BoxFit.fill,
//                         ),
//                       ],
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
