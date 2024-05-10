import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectbluesky/components/placeholder_challenges.dart';
import 'package:projectbluesky/input/challengeinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectbluesky/services/challengeServices.dart';
import 'package:projectbluesky/userProfile/user_profile.dart';
import 'package:projectbluesky/leaderboard/leaderboard_functions.dart';


// Assuming DailyChallenge is defined elsewhere (e.g., in a separate file)
class DailyChallenge {
  // Define the properties of a DailyChallenge object (e.g., title, description, reward)
}

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

  // Future<Map<String, List<DailyChallenge>>> getDailyChallenges() async {
  //   // Get reference to the daily_challenges collection
  //   final collection = FirebaseFirestore.instance.collection('daily_challenges');

  //   // Get all documents as a query snapshot
  //   final snapshot = await collection.get();

  //   // Convert snapshot data to a map with empty lists for each user
  //   final challenges = snapshot.docs.fold<Map<String, List<DailyChallenge>>>(
  //     {},
  //     (previousValue, element) {
  //       final data = element.data();
  //       final userId = data['userID']; // Assuming 'userID' field exists
  //       previousValue[userId] ??= []; // Create empty list if not present
  //       previousValue[userId]!.add(DailyChallenge.fromMap(data)); // Assuming fromMap is defined in DailyChallenge
  //       return previousValue;
  //     },
  //   );

  //   return challenges;
  // }
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
            child: Icon(
              Icons.person,
              size: 72,
            ),
          ),
        ),
        // Add some space between the button and label
        Center(
          child: Text(
            _email,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        // const PlaceHolder_Challenges(
        //   challengeName: "Daily Challenges",
        //   challengeContent: "lorem eplisum",
        // ),
        const PlaceHolder_Challenges(
          challengeName: "Monthly Challenges",
          challengeContent: "Monthly Ranking",
        ),
        Expanded(
          child: FutureBuilder(
            future: getFromFireStore(), // Use the modified function
            builder: (context, snapshot) {
              // ...
              if (snapshot.hasError || snapshot.data == null) {
                // Handle error
                return Text('Error: ${snapshot.error ?? "Data is null"}');
              }

              final challenges = snapshot.data!; // Non-null assertion
              print(challenges);
              if (challenges.isEmpty) {
                return Text('No challenges found.');
              }

              // Calculate total rewards for each username
Map<String, int> leaderboard = {};

challenges.forEach((username, userChallenges) {
  int totalReward = 0;
  userChallenges.forEach((challenge) {
    totalReward += challenge.reward ?? 0; // Assuming reward is nullable
  });
  leaderboard[username] = totalReward;
});

// Sort the leaderboard by total rewards in descending order
List<MapEntry<String, int>> sortedLeaderboard = leaderboard.entries.toList()
  ..sort((a, b) => b.value.compareTo(a.value));

// Display the leaderboard
return Column(
  children: [
    Text(
      'Leaderboard',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 10),
    ListView.builder(
      shrinkWrap: true,
      itemCount: sortedLeaderboard.length,
      itemBuilder: (context, index) {
        final entry = sortedLeaderboard[index];
        return ListTile(
          title: Text(entry.key),
          subtitle: Text('Total Reward: ${entry.value}'),
        );
      },
    ),
  ],
);

            },
          ),
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
