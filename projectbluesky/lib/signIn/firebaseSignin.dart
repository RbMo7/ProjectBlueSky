import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> register(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('register vo');

      // Get the documents matching the email (wait for completion)
      try {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        print('check garyo'); // This will print after data is retrieved
        final List<DocumentSnapshot> documents = result.docs;

        print(result.docs.toList());
        if (documents.isEmpty) {
          print('empty xw');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': email,
            'name': name,
          });
        }
      } catch (e) {
        print('fireStore failed: ${e.toString()}');
      }
      return 'success'; // Registration successful, no error message
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if registration fails
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success'; // Login successful, no error message
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if login fails
    }
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      return 'success'; // Logout successful, no error message
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if logout fails
    }
  }

  Future<String?> getCurrentUser() async {
    return _auth.currentUser!.uid;
  }
}
