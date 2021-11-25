import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/subjects.dart';


class Utils{
  static List<Subjects> getMockedSubjects(){
    return [
      Subjects(
          subject_id: 1,
          name: "RPL",
          user_id: 1
      ),
      Subjects(
          subject_id: 2,
          name: "DMJ",
          user_id: 1
      ),
      Subjects(
          subject_id: 3,
          name: "KemJar",
          user_id: 1
      ),
      Subjects(
          subject_id: 4,
          name: "Probstok",
          user_id: 1
      )

    ];

  }
}