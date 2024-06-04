import 'package:cloud_firestore/cloud_firestore.dart';

class FAQs{
  final List<QueAns>? queAns;

  FAQs({
    this.queAns
});

  Map<String, dynamic> toMap() {
    return {
      'queAns': queAns != null ? queAns!.map((queAns) => queAns.toMap()).toList() : null,
    };
  }

  factory FAQs.fromMap(Map<String, dynamic> map) {
    return FAQs(
      queAns: map['queAns'] != null ? List<QueAns>.from(map['queAns'].map((x) => QueAns.fromMap(x))) : null,
    );
  }
}



class QueAns {
  final String question;
  final String answer;
  final DateTime timestamp;

  QueAns( {required this.question, required this.answer,required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      "timestamp":timestamp,
    };
  }

  factory QueAns.fromMap(Map<String, dynamic> map) {
    return QueAns(
      question: map['question'],
      answer: map['answer'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}