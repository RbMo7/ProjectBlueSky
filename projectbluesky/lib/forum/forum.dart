import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectbluesky/services/challengeServices.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  Firebase _firebase = Firebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, DailyChallenge>>(
          future: getFromFireStore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              // Extract challenges and their users from snapshot data
              final challenges = snapshot.data!.values.toList();
              final users = snapshot.data!.keys.toList();

              return ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'User: ${users[index]}',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(0, 156, 255, 0.7)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${challenges[index].title}',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text('${challenges[index].description}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                            // Add more fields from DailyChallenge as needed
                            const SizedBox(
                                height:
                                    8), // Add some space between text and image
                            if (challenges[index].picture != null)
                              Image.network(
                                challenges[index].picture!,
                                width: double
                                    .infinity, // Make the image fill the width of the ListTile
                                fit: BoxFit
                                    .cover, // Adjust the image to cover the space
                              ),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    // Add onTap handler if needed
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
