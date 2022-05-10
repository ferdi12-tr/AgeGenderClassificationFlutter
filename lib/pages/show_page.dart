import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thales/services/classifier_service.dart';

class ShowPage extends StatelessWidget {
  final XFile? Ximage;
  List<dynamic>? age;
  List<dynamic>? gender;
  String resultText =
      ''; // this text will be filled as soon as we get the result

  ShowPage({required this.Ximage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo, title: const Text('Show Result')),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.cyan, Colors.purpleAccent])),
          child: ListView(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.all(10),
                elevation: 20,
                child: Ximage == null
                    ? const Image(image: AssetImage('assets/images/logo.png'))
                    : Image.file(
                        File(Ximage!.path),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    onPrimary: Colors.white
                  ),
                  onPressed: () async {
                    await getResults(context);
                  },
                  child: const Text('Get Result'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<ClassifierService>(
                builder: (context, value, child) {
                  return value.isBusy == true
                      ? showProcessIndicator()
                      : gender == null
                          ? buildTextCard('Press Get Result Button')
                          : buildTextCard(resultText);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getResults(BuildContext context) async {
    age = (await context.read<ClassifierService>().getAge(Ximage))!;
    gender = (await context.read<ClassifierService>().getGender(Ximage))!;

    age == null || gender == null
        ? resultText = "We cannot receive any information"
        : resultText =
            'This person is ${gender!.first["label"]} and about ${age!.first["label"]} years old.';
  }
}

Widget showProcessIndicator() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 20,
        ),
        (SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )),
      ],
    );

Widget buildTextCard(String text) => Card(
    elevation: 10,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.purpleAccent, Colors.purple],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    ));
