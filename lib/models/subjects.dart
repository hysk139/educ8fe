import 'dart:ui';

class Subjects{
  int? subject_id;
  String? name;
  int? user_id;


  Subjects(
      {
        this.subject_id,
        this.name,
        this.user_id
      }
      );


  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      subject_id: json['subject_id'],
      name: json['name'],
      user_id: json['user_id'],
    );
  }


}