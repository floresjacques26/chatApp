import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
      ),
      body: Center(
        child: Text("Bem vindo ao chat_app!"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Feed'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/feedback');
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text('Register'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
