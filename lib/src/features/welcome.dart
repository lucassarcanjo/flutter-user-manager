import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 72, left: 24, right: 24, bottom: 144),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 100,
            ),
            Image.asset('assets/lime_logo.png'),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'This app streamlines user management with powerful features and an intuitive interface, enabling seamless handling of registration, authentication, and profile management.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/login'),
              child: const Text('Start now!'),
            )
          ],
        ),
      ),
    );
  }
}
