import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/viewmodels/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserViewModel>(
              builder: (context, userViewModel, child) {
                return Text(
                  'User: ${userViewModel.userName}, Email: ${userViewModel.userEmail}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                );
              },
            ),
            TextButton(
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  User data = User(name: "gade", email: "email@gmail.com");
                  String dataEncoded = jsonEncode(data.toJson());
                  await prefs.setString('users', dataEncoded);
                } catch (err) {
                  print("err: $err");
                }
              },
              child: Text("save to storage!"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  String userDataString = prefs.getString('users') ?? "";
                  Map<String, dynamic> userData = jsonDecode(userDataString);
                  var finalData = User.fromJson(userData);
                  userProvider.updateData(finalData);
                } catch (err) {
                  print("err: $err");
                }
              },
              child: Text("get from storage"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Update user data by fetching it from the URL
          await Provider.of<UserViewModel>(context, listen: false)
              .fetchUserData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
