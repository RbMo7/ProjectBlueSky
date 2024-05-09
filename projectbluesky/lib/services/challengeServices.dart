

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';

Future<void> addToFirestore(DailyChallenge challenge) async {
    try {
      await FirebaseFirestore.instance.collection('daily_challenges').add(challenge.toJson());
      print('Daily challenge added to Firestore successfully');
    } catch (error) {
      print('Error adding daily challenge to Firestore: $error');
    }
  }