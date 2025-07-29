import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  /// Convert file to base64 string
  static Future<String> fileToBase64(File file) async {
    try {
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      return base64String;
    } catch (e) {
      throw Exception('Failed to convert file to base64: $e');
    }
  }

  /// Convert base64 string to file
  static Future<File> base64ToFile(String base64String, String filePath) async {
    try {
      List<int> bytes = base64Decode(base64String);
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      throw Exception('Failed to convert base64 to file: $e');
    }
  }

  /// Get file extension from path
  static String getFileExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  /// Get file name from path
  static String getFileName(String path) {
    return path.split('/').last;
  }

  /// Check if file is an image
  static bool isImage(String path) {
    final ext = getFileExtension(path);
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  /// Check if file is a document
  static bool isDocument(String path) {
    final ext = getFileExtension(path);
    return ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'].contains(ext);
  }

  static Future<File> bytesToFile(Uint8List bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }
}
