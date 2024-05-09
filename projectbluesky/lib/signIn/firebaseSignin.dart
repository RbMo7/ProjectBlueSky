import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      return'success'; // Logout successful, no error message
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if logout fails
    }
  }
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
