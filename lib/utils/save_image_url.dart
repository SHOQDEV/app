import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

saveImage(String image,String name) async {
      File imagePlaceHolder = await ImageUtils.imageToFile(image);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentDirectory.path;
      String fullPaths = "$documentPath/$name";
      File myFile = File(fullPaths);
      myFile.writeAsBytesSync(imagePlaceHolder.readAsBytesSync());
      return fullPaths;
}
class ImageUtils {
  static Future<File> imageToFile(String image) async {
    var bytes = await rootBundle.load(image);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/imagesService.jpg');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}
