import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeInput extends StatefulWidget {
  const ChallengeInput({Key? key});

  @override
  State<ChallengeInput> createState() => _ChallengeInputState();
}

class _ChallengeInputState extends State<ChallengeInput> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _imageFileList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "WHAT DID YOU DO FOR A",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Center(
              child: Text(
                "BLUE SKY?",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "What did you contribute?",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _titleController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _desController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tell us a little more in detail",
                suffixIcon: IconButton(
                  onPressed: () {
                    _desController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: selectImages,
                child: const Text("Upload some proof of contribution"),
              ),
            ),
            _buildImagePreview(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(onPressed: () {}, child: (Text("Submit"))),
            )
          ],
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages =
        await _imagePicker.pickMultiImage(imageQuality: 80);

    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFileList = selectedImages;
      });
    }
  }

  Widget _buildImagePreview() {
    return _imageFileList.isEmpty
        ? Container()
        : Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _imageFileList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(_imageFileList[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ],
          );
  }
}
