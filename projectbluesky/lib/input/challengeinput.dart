import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeInput extends StatefulWidget {
  const ChallengeInput({super.key});

  @override
  State<ChallengeInput> createState() => _ChallengeInputState();
}

class _ChallengeInputState extends State<ChallengeInput> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "What did you contibute?",
                    suffixIcon: IconButton(
                      onPressed: () {
                        _titleController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    )),
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
                )),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Upload some proof of contribution"))
          ],
        ),
      ),
    );
  }
}
