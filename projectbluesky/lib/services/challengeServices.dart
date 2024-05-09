import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';

Future<void> addToFirestore(DailyChallenge challenge) async {
  try {
    await FirebaseFirestore.instance
        .collection('daily_challenges')
        .add(challenge.toJson());
    print('Daily challenge added to Firestore successfully');
  } catch (error) {
    print('Error adding daily challenge to Firestore: $error');
  }
}

Future<Map<String, DailyChallenge>> getFromFireStore() async {
  try {
    // Get daily challenges
    var challengeQuerySnapshot =
        await FirebaseFirestore.instance.collection('daily_challenges').get();

    // Map to store user names and daily challenges
    Map<String, DailyChallenge> challengeMap = {};

    // Iterate through each challenge document
    for (var challengeDoc in challengeQuerySnapshot.docs) {
      // Get user ID from the challenge document
      var userId = challengeDoc['userID'];

      // Get user document from the users collection
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Get user name from the user document
      var userName = userDoc['name'];

      // Create DailyChallenge object
      var challenge = DailyChallenge(
        title: challengeDoc['title'],
        description: challengeDoc['description'],
        picture: challengeDoc['picture'],
        userID: challengeDoc['userID'],
        challengeDate: DateTime.parse(challengeDoc['challengeDate']),
      );

      // Add entry to challenge map with user name as key and challenge object as value
      challengeMap[userName] = challenge;
    }

    return challengeMap;
  } catch (e) {
    // Handle errors
    print('Error fetching challenges: $e');
    return {}; // Return empty map in case of error
  }
}
