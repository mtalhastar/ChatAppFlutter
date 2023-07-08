import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerS extends StatefulWidget {
  const ImagePickerS({required this.addimage, super.key});
  final void Function(File image) addimage;

  @override
  State<ImagePickerS> createState() => _ImagePickerSState();
}

class _ImagePickerSState extends State<ImagePickerS> {
  File? imagefiles;
  void pickImages() async {
    final imagefile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 40,
        maxHeight: 40);

    if (imagefile == null) {
      return;
    }
    setState(() {
      imagefiles = File(imagefile.path);
      widget.addimage(imagefiles!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            foregroundImage: imagefiles != null ? FileImage(imagefiles!) : null,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: pickImages,
                child: const Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 5,
                    ),
                    Text('add image')
                  ],
                )),
          ])
        ],
      ),
    );
  }
}
