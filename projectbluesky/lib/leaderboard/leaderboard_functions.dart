import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> fetchAndSortUsers() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  
  final List<DocumentSnapshot> sortedUsers = querySnapshot.docs;
  sortedUsers.sort((a, b) => b['rewardPoints'].compareTo(a['rewardPoints']));
  
  return sortedUsers;
}
