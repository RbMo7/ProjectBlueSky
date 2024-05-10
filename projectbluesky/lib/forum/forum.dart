import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectbluesky/services/challengeServices.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        child: FutureBuilder<List<DailyChallenge>>(
          future: getSortedChallenges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final challenges = snapshot.data!;

              return ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  var challenge = challenges[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: getUserName(challenge.userID),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox.shrink();
                          }
                          if (userSnapshot.hasData) {
                            return Text(
                              'User: ${userSnapshot.data}',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                            );
                          } else if (userSnapshot.hasError) {
                            return Text('Error: ${userSnapshot.error}');
                          } else {
                            return const Text('No data available');
                          }
                        },
                      ),
                      ListTile(
                        title: Text(
                          '${challenge.title}',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${challenge.description}',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if (challenge.picture != null)
                              Image.network(
                                challenge.picture!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
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

  Future<List<DailyChallenge>> getSortedChallenges() async {
    try {
      var challengeMap = await getFromFireStore();
      List<DailyChallenge> sortedChallenges = [];

      // Flatten the map values into a single list
      challengeMap.values.forEach((challenges) {
        sortedChallenges.addAll(challenges);
      });

      // Sort the list of challenges by challenge date in descending order
      sortedChallenges.sort((a, b) => b.challengeDate.compareTo(a.challengeDate));

      return sortedChallenges;
    } catch (e) {
      print('Error fetching and sorting challenges: $e');
      return [];
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return userDoc['name'];
    } catch (e) {
      print('Error fetching user name: $e');
      return '';
    }
  }
}
