import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ClassifierService with ChangeNotifier {
  File? _imageFile;
  Map<String, double>? predicted;
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  Future<List?> getAge(XFile? Ximage) async {
    _isBusy = true;
    notifyListeners();
    _imageFile = File(Ximage!.path);

    String? res = await Tflite.loadModel(
      model: 'assets/best_age_model.tflite',
      labels: 'assets/labels_age.txt',
    );
    var recognitions = await Tflite.runModelOnImage(
      path: _imageFile!.path,
      threshold: 0.5,
      asynch: true
    );
    // sleep(const Duration(minutes: 1));
    return recognitions;
  }

  Future<List?> getGender(XFile? Ximage) async {

    _imageFile = File(Ximage!.path);

    String? res = await Tflite.loadModel(
      model: 'assets/best_gender_model.tflite',
      labels: 'assets/labels_gender.txt',
    );
    var recognitions = await Tflite.runModelOnImage(
        path: _imageFile!.path,
        threshold: 0.5,
        asynch: true
    );
    // sleep(const Duration(minutes: 1));
    _isBusy = false;
    notifyListeners();
    return recognitions;
  }
}
