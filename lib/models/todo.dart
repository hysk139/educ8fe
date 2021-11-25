import 'dart:ui';

class Todo{
  int? todo_id;
  String? title;
  String? description;
  String? deadline;
  String? type;
  int? topic_id;


  Todo(
      {
        this.todo_id,
        this.title,
        this.description,
        this.deadline,
        this.type,
        this.topic_id
      }
      );


  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        todo_id: json['todo_id'],
        title: json['title'],
        description: json['description'],
        deadline : json['deadline'],
        type : json['type'],
        topic_id: json['topic_id']
    );
  }


}