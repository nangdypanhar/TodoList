import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:todolist/Model/user.dart';

class UserProvider extends ChangeNotifier {
  List<dynamic> userData = [];

  Future<bool> login(String email, String password) async {
    final uri = Uri.parse('http://10.0.2.2:3000/users/login');
    // Create the request body
    final Map<String, dynamic> loginData = {
      'user': {
        'email': email,
        'password': password,
      }
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final data = jsonDecode(response.body);
        print("Logged in successfully: ${data['message']}");

        return true; // Indicate success
        // You might want to save the user info or token here
      } else {
        // Handle unsuccessful login
        try {
          final errorData = jsonDecode(response.body);
          print("Login failed: ${errorData['error'] ?? 'Unknown error'}");
        } catch (e) {
          print("Error decoding response: ${response.body}");
        }
        return false; // Indicate failure
      }
    } catch (e) {
      print('Error: $e');
      return false; // Indicate failure in case of an error
    }
  }

  Future<void> addUser(User user) async {
    final uri = Uri.parse('http://10.0.2.2:3000/users');
    final Map<String, dynamic> newUser = {
      'user': {
        'email': user.email,
        'password': user.password,
        'name': user.name,
      }
    };
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newUser),
      );

      if (response.statusCode == 201) {
        print("User created successfully");
        notifyListeners();
      } else {
        print("Unsuccessful: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print('Error : $e');
    }
  }
}
