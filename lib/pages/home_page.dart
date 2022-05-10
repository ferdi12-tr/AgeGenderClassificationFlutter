import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/logo.png')),
        ),
        title: Text(
          'Uploading',
          style: GoogleFonts.roboto(
              fontStyle: FontStyle.normal, fontSize: 30, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Colors.purpleAccent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fixedSize: const Size(280, 80),
                  primary: Colors.red.shade300,
                  elevation: 20,
                ),
                onPressed: () async {
                  await Picker(context: context, source: ImageSource.camera).pickMedia();
                },
                child: Row(
                  children: const [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 30,
                    ),
                    Text('Picture From Camera'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fixedSize: const Size(280, 80),
                  primary: Colors.green.shade300,
                  elevation: 20,
                ),
                onPressed: () async {
                  await Picker(context: context, source: ImageSource.gallery).pickMedia();  // go to the picker class and pick the image according to source
                },
                child: Row(
                  children: const [
                    Icon(Icons.folder),
                    SizedBox(
                      width: 30,
                    ),
                    Text('Picture From Gallery'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
