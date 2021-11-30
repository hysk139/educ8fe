import 'dart:ui';

class Topic{
  int? topic_id;
  String? topic_name;
  String? materials;
  String? video;
  int? subject_id;


  Topic(
      {
        this.topic_id,
        this.topic_name,
        this.materials,
        this.video,
        this.subject_id
      }
      );


  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
        topic_id: json['topic_id'],
        topic_name: json['topic_name'],
        materials: json['materials'],
        video : json['video'],
        subject_id: json['subject_id']
    );
  }


}