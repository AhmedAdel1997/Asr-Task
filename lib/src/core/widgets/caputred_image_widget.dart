// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_base/src/config/language/locale_keys.g.dart';
// import 'package:flutter_base/src/config/res/color_manager.dart';
// import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
// import 'package:flutter_base/src/core/widgets/custom_container_with_shadow.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';

// import '../../config/res/constants_manager.dart';
// import '../helpers/app_location.dart';
// import '../navigation/navigator.dart';
// import 'buttons/loading_button.dart';

// class CaputredImageWidget extends StatefulWidget {
//   final File file;
//   const CaputredImageWidget({
//     super.key,
//     required this.file,
//   });

//   @override
//   State<CaputredImageWidget> createState() => _CaputredImageWidgetState();
// }

// class _CaputredImageWidgetState extends State<CaputredImageWidget> {
//   WidgetsToImageController controller = WidgetsToImageController();
//   String address = '';
//   Future<void> getAddress() async {
//     final position = await sl<AppLocation>().determinePosition();
//     if (position != null) {
//       try {
//         List<geocoding.Placemark> placemarks = [];
//         placemarks.addAll(await geocoding.placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         ));
//         if (placemarks.isNotEmpty) {
//           geocoding.Placemark place = placemarks.first;
//           setState(() {
//             address =
//                 '${place.street}, ${place.thoroughfare},${place.administrativeArea},${place.country}';
//           });
//         }
//       } catch (e) {
//         setState(() {
//           address =
//               '${position.latitude.toStringAsFixed(4)},${position.longitude.toStringAsFixed(4)}';
//         });
//       }
//     }
//   }

//   Uint8List? bytes;

//   @override
//   void initState() {
//     super.initState();
//     getAddress();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomContainerWithShadow(
//           child: LoadingButton(
//         title: LocaleKeys.save,
//         onTap: () async {
//           if (address.isEmpty) {
//             await getAddress();
//           } else {
//             final bytes = await controller.capture();
//             setState(() {
//               this.bytes = bytes;
//             });
//             if (bytes == null) {
//               return;
//             }
//             Directory directory = await getApplicationDocumentsDirectory();
//             File file = File('${directory.path}/${DateTime.now()}');
//             await file.writeAsBytes(bytes);
//             Go.back<File>(file);
//           }
//         },
//       )),
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//       ),
//       body: Center(
//         child: WidgetsToImage(
//           controller: controller,
//           child: Stack(
//             children: [
//               Image.file(widget.file),
//               Positioned(
//                 right: 20,
//                 top: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       color: AppColors.black.withValues(alpha: 0.2),
//                       child: Text(
//                         DateFormat('EEEE, d MMMM yyyy \'at\' hh:mm:ss a')
//                             .format(DateTime.now()),
//                         style: const TextStyle()
//                             .setWhiteColor
//                             .setFontFamily
//                             .s16
//                             .medium,
//                       ),
//                     ),
//                     ...List.generate(address.split(',').length, (index) {
//                       return Container(
//                         color: AppColors.black.withValues(alpha: 0.2),
//                         child: Text(
//                           address.split(',')[index],
//                           style: const TextStyle()
//                               .setWhiteColor
//                               .setFontFamily
//                               .s16
//                               .medium,
//                         ),
//                       );
//                     })
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
