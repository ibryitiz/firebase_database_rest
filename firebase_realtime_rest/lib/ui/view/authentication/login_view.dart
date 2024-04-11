import 'package:firebase_realtime_rest/core/models/user/user_auth_error.dart';
import 'package:firebase_realtime_rest/core/models/user/user_request.dart';
import 'package:firebase_realtime_rest/core/services/firebase_service.dart';
import 'package:firebase_realtime_rest/ui/view/home/fire_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Username"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Password"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                FirebaseService service = Provider.of<FirebaseService>(
                  context,
                  listen: false,
                );
                var result = await service.postUser(
                  UserRequest(
                    username!,
                    password!,
                    true,
                  ),
                );
                if (result is FirebaseAuthError) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result.error!.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FireHome(),
                    ),
                  );
                }
              },
              label: const Text("Login"),
              icon: const Icon(Icons.login),
            )
          ],
        ),
      ),
    );
  }
}
