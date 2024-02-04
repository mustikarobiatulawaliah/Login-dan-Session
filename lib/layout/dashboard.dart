import 'package:examplebloc/layout/addnews.dart';
import 'package:examplebloc/layout/managenews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import 'addnews.dart';

class WelcomeScreen extends StatelessWidget {
  final String sessionToken;

  WelcomeScreen({required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!'),
            Text('Session Token: $sessionToken'),
            ElevatedButton(
              onPressed: () {
                // Dispatch logout event to Bloc
                context.read<LoginBloc>().add(const ProsesLogout());
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                //Navigasi ke halaman Add News
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsForm()),
                );
              },
              child: Text('Tambah Berita'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageNews()),
                );
              },
              child: Text('Kelola Berita'),
            ),
          ],
        ),
      ),
    );
  }
}
