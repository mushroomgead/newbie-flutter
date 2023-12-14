import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodels/user_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM Example'),
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
