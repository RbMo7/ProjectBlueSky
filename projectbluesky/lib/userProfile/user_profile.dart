import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectbluesky/components/placeholder_challenges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectbluesky/modal/dailyChallenge.dart';
import 'package:projectbluesky/services/challengeServices.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _username = '';
  String _email = '';
String? userId =  FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    // Retrieve the current user when the widget initializes
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // If the user is signed in, you can retrieve their username and email
      setState(() {
        _username = currentUser.displayName ?? '';
        _email = currentUser.email ?? '';
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // After signing out, navigate back to the previous page or home page
    // Here you can replace it with your navigation logic
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser?.photoURL ?? 'https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.webp',
                ),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 20),
              Text(
                'Username: $_username',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Email: $_email',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('Logout'),
        
              ),
              Expanded(
            child: FutureBuilder<Map<String, List<DailyChallenge>>>(
  future: getUsersChallenge(userId!),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator()); // Placeholder while loading
    }
    if (snapshot.hasError || snapshot.data == null) {
      return Text('Error: ${snapshot.error ?? "Data is null"}');
    }
    final userName = snapshot.data!.keys.first;
    final challengeMap = snapshot.data!; // Non-null assertion
    final userChallenges = challengeMap[userName]; // Get user's challenges
    if (userChallenges == null || userChallenges.isEmpty) {
      return Text('No challenges found for this user.');
    }

    return ListView.builder(
      itemCount: userChallenges.length,
      itemBuilder: (context, index) {
        final challenge = userChallenges[index];
        return ListTile(
          title: Text(challenge.title),
          subtitle: Text(challenge.description),
          trailing: Text('Reward: ${challenge.reward}'),
          onTap: () {
            // Add onTap functionality if needed
          },
        );
      },
    );
  },
),

          ),
            ],
          ),
          
        ),
      ),
      
    );
  }

  
}
