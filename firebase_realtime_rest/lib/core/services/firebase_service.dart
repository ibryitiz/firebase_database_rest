import 'dart:convert';
import 'dart:io';

import 'package:firebase_realtime_rest/core/models/student.dart';
import 'package:firebase_realtime_rest/core/models/user.dart';
import 'package:firebase_realtime_rest/core/models/user/user_auth_error.dart';
import 'package:firebase_realtime_rest/core/models/user/user_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseService extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const String FIREBASE_URL = "Your firebase url";
  // ignore: constant_identifier_names
  static const String FIREBASE_AUTH_URL = "your firebase auth url";

  Future postUser(UserRequest userRequest) async {
    var jsonModel = json.encode(userRequest.toJson());
    final response = await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }

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

  //! dOĞRU ÇALIŞSADA KENDİ KEYİNİ ATIYOR FİREBASE O KEYİ DEĞİŞTİREMEDİM.
  // Future<User> createUser(String name) async {
  //   final Map<String, dynamic> userData = {
  //     'name': name,
  //   };

  //   final response = await http.post(
  //     Uri.parse("$FIREBASE_URL/users.json"), // Kullanıcı ID'sini belirtilen URL'ye ekliyoruz.
  //     body: json.encode(userData),
  //   );

  //   if (response.statusCode == 200) {
  //     final user = User.fromJson(json.decode(response.body));
  //     return user;
  //   } else {
  //     throw Exception("Failed to load put");
  //   }
  // }

  Future<Student> createStudent(String name, String number) async {
    Map<String, dynamic> request = {
      "name": name,
      "number": number,
    };

    final response = await http.post(Uri.parse("$FIREBASE_URL/students.json"), body: json.encode(request));
    if (response.statusCode == 200) {
      final student = Student.fromJson(
        json.decode(response.body),
      );
      return student;
    } else {
      throw Exception("Failed to load put");
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
