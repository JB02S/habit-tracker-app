import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_habit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Habits",),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddHabitPage())
                );
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Card(
              child: Text("TODO")
            )
          );
        },
      ),
    );
  }
}
