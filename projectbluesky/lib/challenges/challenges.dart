import 'package:flutter/material.dart';
import 'package:projectbluesky/components/placeholder_challenges.dart';
import 'package:projectbluesky/input/challengeinput.dart';

class Challenges extends StatefulWidget {
  const Challenges({Key? key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PlaceHolder_Challenges(
            challengeName: "Daily Challenges",
            challengeContent: "lorem eplisum"),
        const PlaceHolder_Challenges(
            challengeName: "Monthly Challenges",
            challengeContent:
                "Time for our monthly challenge alkfjkdlsjf akljdsflkajsdkfl jakfjaldskfjlkadsjfklsaj"),
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
                        })
                  }),
        )
      ],
    );
  }

  Widget buildButton({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(onPressed: onClicked, child: Text(text));
}
