import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserViewModel extends ChangeNotifier {
  User _user = User(name: 'Loading...', email: "email@gmail.com");

  String get userName => _user.name;
  String get userEmail => _user.email;

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10) + 1;
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/users/${generateRandomNumber()}'));
      if (response.statusCode == 200) {
        // Parse the response JSON and update the user data
        final Map<String, dynamic> data = json.decode(response.body);
        _user = User(name: data['name'], email: data['email']);
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
