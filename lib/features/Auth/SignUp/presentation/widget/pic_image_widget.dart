import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  final Function(XFile) onImagePicked;   

  const PickImageWidget({
    Key? key, 
    required this.onImagePicked,
  }) : super(key: key);

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(File(selectedImage!.path))
            : const AssetImage('assets/images/avatar.png'),
        child: Stack(
          children: [
            Positioned(
              bottom: 3,
              right: 10, 
              child: GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    setState(() {
                      selectedImage = file;
                    });
                    widget.onImagePicked(file); 
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.camera_alt_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
