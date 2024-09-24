import 'package:flutter/material.dart';

class Afterlogin extends StatelessWidget {
  const Afterlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("This is after login"),
      ),
    );
  }
}
