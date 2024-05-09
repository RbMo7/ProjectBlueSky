import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';
import 'package:projectbluesky/services/challengeServices.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';

class ChallengeInput extends StatefulWidget {
  const ChallengeInput({Key? key});

  @override
  State<ChallengeInput> createState() => _ChallengeInputState();
}

class _ChallengeInputState extends State<ChallengeInput> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image; 
  String imageUrl = "" ; 

Firebase _firebase = Firebase();

  
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
              child: ElevatedButton(onPressed: () async {


                        if (_image == null) return;
                        //getting reference to storage root
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                            
                        //reference for the images to be stored
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        //Store the file
                        try {
                          await referenceImageToUpload
                              .putFile(File(_image!.path));

                          //get the url of the image
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to Upload Image :$error"),
                            ),
                          );
                        }

      
      String? uid = await _firebase.getCurrentUser(); 


              DailyChallenge _challenge = new DailyChallenge(
                title: _titleController.text,
                description: _desController.text,
                picture: imageUrl,
                userID: uid!, 
                challengeDate: DateTime.now(), 
              ); 

 await  addToFirestore(_challenge); 

              }, child: (Text("Submit"))),
            )
          ],
        ),
      ),
    );
  }

  void selectImages() async {
    final XFile? selectedImages =
        await _imagePicker.pickImage(source:ImageSource.camera);

    if (selectedImages != null ) {
      setState(() {
        _image = selectedImages;
      });
    }
  }

  Widget _buildImagePreview() {
    return _image == null 
        ? Container()
        : Column(
            children: [
               Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover,
                  )
                
              
            ],
          );
  }
}
