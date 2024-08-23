class Question {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final String ownerName;
  final int viewCount;
  final int answerCount;
  final int score;
  final bool isAnswered;
  final DateTime creationDate;

  Question({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.ownerName,
    required this.viewCount,
    required this.answerCount,
    required this.score,
    required this.isAnswered,
    required this.creationDate,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['question_id'],
      title: json['title'],
      body: json['body'] ?? '',
      tags: List<String>.from(json['tags']),
      ownerName: json['owner']['display_name'],
      viewCount: json['view_count'],
      answerCount: json['answer_count'],
      score: json['score'],
      isAnswered: json['is_answered'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(json['creation_date'] * 1000),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags.join(','),
      'ownerName': ownerName,
      'viewCount': viewCount,
      'answerCount': answerCount,
      'score': score,
      'isAnswered': isAnswered ? 1 : 0,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      tags: map['tags'].split(','),
      ownerName: map['ownerName'],
      viewCount: map['viewCount'],
      answerCount: map['answerCount'],
      score: map['score'],
      isAnswered: map['isAnswered'] == 1,
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
    );
  }
}
