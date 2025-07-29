import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/core/extensions/padding_extension.dart';
import 'package:flutter_base/src/core/widgets/custom_loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/language/locale_keys.g.dart';
import '../navigation/navigator.dart';
import '../widgets/custom_messages.dart';

class Helpers {
  static Future<File?> getImage({
    ImageSource? source,
  }) async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
        await picker.pickImage(source: source ?? ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final ImagePicker picker = ImagePicker();
    File? image;
    await showModalBottomSheet(
        context: Go.navigatorKey.currentContext!,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(LocaleKeys.photoLibrary),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(LocaleKeys.camera),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.camera);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
              ],
            ).paddingAll(AppPadding.pH10),
          );
        });
    return image;
  }

  static void shareApp(url) {
    CustomLoading.showFullScreenLoading();
    Share.share(url).whenComplete(() {
      CustomLoading.hideFullScreenLoading();
    });
  }

  static String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'android';
    }
  }

  static Future<void> openGoogleMaps({
    required double lat,
    required double long,
  }) async {
    if (lat == 0.0 || long == 0.0) {
      return;
    }
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";

    final Uri encodedURl = Uri.parse(googleMapslocationUrl);

    if (await canLaunchUrl(encodedURl)) {
      await launchUrl(encodedURl, mode: LaunchMode.externalApplication);
    } else {
      MessageUtils.showErrorSnackBar(LocaleKeys.locationRequired);
    }
  }
}
