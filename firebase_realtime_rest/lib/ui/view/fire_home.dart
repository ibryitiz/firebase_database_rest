import 'package:firebase_realtime_rest/core/models/student.dart';
import 'package:firebase_realtime_rest/core/models/user.dart';
import 'package:firebase_realtime_rest/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireHome extends StatefulWidget {
  const FireHome({super.key});

  @override
  State<FireHome> createState() => _FireHomeState();
}

class _FireHomeState extends State<FireHome> {
  @override
  Widget build(BuildContext context) {
    debugPrint("buidl çalıştı");
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<FirebaseService>(
          builder: (context, viewModel, child) {
            return studentFutureBuilder(viewModel);
          },
        ));
  }

  Widget userFutureBuilder(viewModel) {
    debugPrint("user builder çalıştı");
    return FutureBuilder<List<User>>(
      future: viewModel.getUsers(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return _listUsers(snapshot.data!);
            } else {
              return _notFoundWidget;
            }
          default:
            return _waitingWidget;
        }
      },
    );
  }

  Widget studentFutureBuilder(viewModel) {
    debugPrint("student builder çalıştı");
    return FutureBuilder<List<Student>>(
      future: viewModel.getStudents(),
      builder: (context, AsyncSnapshot<List<Student>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return _listStudent(snapshot.data!);
            } else {
              return _notFoundWidget;
            }
          default:
            return _waitingWidget;
        }
      },
    );
  }

  Widget _listUsers(List<User> list) {
    debugPrint("user list çalıştı");

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _cardUser(list[index]),
    );
  }

  Widget _cardUser(User user) {
    return Card(
      child: ListTile(
        title: Text(user.name),
      ),
    );
  }

  Widget _listStudent(List<Student> list) {
    debugPrint("student list çalıştı");

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _cardStudent(list[index]),
    );
  }

  Widget _cardStudent(Student student) {
    return Card(
      child: ListTile(
        title: Text(student.name),
        subtitle: Text(student.number),
      ),
    );
  }

  Widget get _notFoundWidget => const Center(
        child: Text("Not Found"),
      );
  Widget get _waitingWidget => const Center(
        child: CircularProgressIndicator(),
      );
}
