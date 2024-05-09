import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceHolder_Challenges extends StatelessWidget {
  final String challengeName;
  final String challengeContent;
  const PlaceHolder_Challenges({
    super.key,
    required this.challengeName,
    required this.challengeContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromRGBO(227, 242, 253, 1),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challengeName,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,
              )),
          Text(
            challengeContent,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          )
        ],
      ),
    );
  }
}
