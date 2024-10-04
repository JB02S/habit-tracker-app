import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_provider.dart';
import 'package:habit_tracker_app/main.dart';
import 'package:provider/provider.dart';
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
        itemCount: context.watch<HabitProvider>().habits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Card(
              child: Text(context.watch<HabitProvider>().habits[index].title)
            )
          );
        },
      ),
    );
  }
}
