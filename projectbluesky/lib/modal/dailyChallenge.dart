class DailyChallenge {
  final String userID;
  final String title;
  final String description;
  final List<String> pictures;
  final DateTime challengeDate;

  DailyChallenge({
    required this.userID,
    required this.title,
    required this.description,
    required this.pictures,
    required this.challengeDate,
  });

  factory DailyChallenge.fromJson(Map<String, dynamic> json) {
    return DailyChallenge(
      userID: json['userid'],
      challengeDate: DateTime.parse(json['challengeDate']),
      description: json['description'],
      title: json['title'],
      pictures: List<String>.from(json['pictures']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'challengeDate': challengeDate.toIso8601String(),
      'description': description,
      'title': title,
      'pictures': pictures,
    };
  }
}
