import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/pages/new_acc.dart';
import 'package:todolist/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPw = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to our App",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
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
                    obscureText: showPw,
                    controller: passwordController,
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
                  TextButton(
                    onPressed: () async {
                      final String email = emailController.text;
                      final String password = passwordController.text;
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);

                      print(email);
                      print(password);

                      if (email.isNotEmpty && password.isNotEmpty) {
                        bool loginSuccess =
                            await userProvider.login(email, password);

                        if (loginSuccess) {
                          // If login is successful, navigate to HomePage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } else {
                          // Show error message

                          print(
                              "Login failed. Please check your email and password.");
                        }
                      } else {
                        print("Please fill in all fields.");
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewAcc()),
                      );
                    },
                    child: const Text("Haven't account ? "),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
