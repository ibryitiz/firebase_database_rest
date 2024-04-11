import 'dart:convert';
import 'dart:io';

import 'package:firebase_realtime_rest/core/models/student.dart';
import 'package:firebase_realtime_rest/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseService extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const String FIREBASE_URL = "YOUR REALTİME DATABASE URL";

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse("$FIREBASE_URL/users.json"));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel.map((e) => User.fromJson(e as Map<String, dynamic>)).toList().cast<User>();
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse("$FIREBASE_URL/students.json"));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final studentList = <Student>[];
        jsonModel.forEach((key, value) {
          final student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });
        return studentList;
      default:
        return Future.error(response.statusCode);
    }
  }
}
