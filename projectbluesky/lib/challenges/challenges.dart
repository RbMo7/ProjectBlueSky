import 'package:flutter/material.dart';
import 'package:projectbluesky/components/placeholder_challenges.dart';
import 'package:projectbluesky/input/challengeinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectbluesky/userProfile/user_profile.dart';

class Challenges extends StatefulWidget {
  const Challenges({Key? key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  String _email = 'guest@example.com'; // Default email value

  @override
  void initState() {
    super.initState();
    // Retrieve the current user when the widget initializes
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // If the user is signed in, you can retrieve their email
      setState(() {
        _email = currentUser.email ?? 'guest@example.com';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          },
          icon: const Center(
            child: Icon(Icons.person, size: 72,),
          ),
        ),
        // Add some space between the button and label
        Center(
          child: Text(
            _email,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const PlaceHolder_Challenges(
          challengeName: "Daily Challenges",
          challengeContent: "lorem eplisum",
        ),
        const PlaceHolder_Challenges(
          challengeName: "Monthly Challenges",
          challengeContent:
              "Time for our monthly challenge alkfjkdlsjf akljdsflkajsdkfl jakfjaldskfjlkadsjfklsaj",
        ),
        Center(
          child: buildButton(
            text: "Participate in the challenge!",
            onClicked: () => {
              showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView(
                      shrinkWrap: true,
                      children: const [ChallengeInput()],
                    ),
                  );
                },
              )
            },
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(onPressed: onClicked, child: Text(text));
}
