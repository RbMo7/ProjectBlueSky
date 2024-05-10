import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

Future<Map<String, List<DailyChallenge>>> getFromFireStore() async {
  try {
    var challengeQuerySnapshot =
        await FirebaseFirestore.instance.collection('daily_challenges').get();

    Map<String, List<DailyChallenge>> challengeMap = {};

    for (var challengeDoc in challengeQuerySnapshot.docs) {
      var userId = challengeDoc['userID'];

      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      var userName = userDoc['name'];

      var challenge = DailyChallenge(
        title: challengeDoc['title'],
        description: challengeDoc['description'],
        picture: challengeDoc['picture'],
        userID: challengeDoc['userID'],
        challengeDate: DateTime.parse(challengeDoc['challengeDate']), 
        reward: challengeDoc['reward'],
      );

      // Check if the user already has entries in the map
      if (challengeMap.containsKey(userName)) {
        // If the user already exists in the map, add the new challenge to the existing list
        challengeMap[userName]!.add(challenge);
      } else {
        // If the user doesn't exist in the map, create a new list and add the challenge to it
        challengeMap[userName] = [challenge];
      }
    }
print(challengeMap);
    return challengeMap;
  } catch (e) {
    print('Error fetching challenges: $e');
    return {};
  }
  
}
Future<Map<String, List<DailyChallenge>>> getUsersChallenge(String userId) async {
  try {
    var challengeQuerySnapshot = await FirebaseFirestore.instance
        .collection('daily_challenges')
        .where('userID', isEqualTo: userId) // Filter challenges by userId
        .get();
        print(challengeQuerySnapshot.docs);
    Map<String, List<DailyChallenge>> challengeMap = {};
    List<DailyChallenge> challenge = [];
    for (var challengeDoc in challengeQuerySnapshot.docs) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      var userName = userDoc['name'];

       challenge.add(DailyChallenge(
        title: challengeDoc['title'],
        description: challengeDoc['description'],
        picture: challengeDoc['picture'],
        userID: challengeDoc['userID'],
        challengeDate: DateTime.parse(challengeDoc['challengeDate']),
        reward: challengeDoc['reward'],
      ));

      // Add the challenge to the map with user name as key
      challengeMap[userName] = challenge;
    }
    
    return challengeMap;
  } catch (e) {
    print('Error fetching challenges: $e');
    return {};
  }

}
  
