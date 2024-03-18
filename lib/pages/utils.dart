import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? filep = await _imagePicker.pickImage(source: source);
  if (filep != null) {
    Uint8List img = await filep.readAsBytes();
    return img;
    //return await _file.readAsBytes();
  }

  print('No Images Selected');
}
