import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../routes/routes.dart';

class Picker {
  Picker({required this.context, required this.source});
  final ImageSource source;
  final BuildContext context;
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;

  Future pickMedia() async {
    final XFile? imageFile = await picker.pickImage(source: source);
    Navigator.of(context)
        .pushNamed(RouteManager.showPage, arguments: imageFile); // push the image file to the route manager class
  }
}
