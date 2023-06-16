import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sns_example/common/utils/toast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<CroppedFile?> cropImage(String imagePath) async {
  final croppedFile = await ImageCropper().cropImage(
    maxHeight: 900,
    maxWidth: 900,
    sourcePath: imagePath,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Change Size',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        doneButtonTitle: 'Select',
        title: 'Change Size',
      )
    ],
  );

  return croppedFile;
}

Future<File?> pickImageFromGallery() async {
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    return File(pickedImage!.path);
  } catch (e) {
    print(e);
    await toast('もう一度お願いします');
    rethrow;
  }
}

Future<File?> pickCropImage() async {
  try {
    var selectedImage = await pickImageFromGallery();
    final croppedFile = await cropImage(selectedImage!.path);
    if (croppedFile != null) {
      return selectedImage = File(croppedFile.path);
    }
  } catch (e) {
    print(e);
    await toast('もう一度お願いします');
    rethrow;
  }
  return null;
}
