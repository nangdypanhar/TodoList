import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Model/user.dart';
import 'package:todolist/pages/login_page.dart';
import 'package:todolist/provider/user_provider.dart';

class NewAcc extends StatefulWidget {
  const NewAcc({super.key});

  @override
  State<NewAcc> createState() => _NewAccState();
}

class _NewAccState extends State<NewAcc> {
  bool showPw = true;
  bool showCPw = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      label: Text("Email"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: showPw,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPw = !showPw;
                          });
                        },
                        icon: Icon(showPw
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye),
                      ),
                      label: const Text("password"),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: cpasswordController,
                    obscureText: showCPw,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showCPw = !showCPw;
                          });
                        },
                        icon: Icon(showCPw
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye),
                      ),
                      label: const Text("confirm password"),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () async {
                      final newUser = User(
                          email: emailController.text,
                          password: passwordController.text,
                          name: "newUser");

                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      await userProvider.addUser(newUser);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text("Already have account ? "),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
