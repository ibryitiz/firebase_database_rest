import 'package:firebase_realtime_rest/app.dart';
import 'package:firebase_realtime_rest/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => FirebaseService(),
    child: const MyApp(),
  ));
}
