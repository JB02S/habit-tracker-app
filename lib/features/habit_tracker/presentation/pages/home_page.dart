import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_event.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import 'add_habit_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _showCheckboxes = false;
  List<bool>? _checkboxValues;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Habits",),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _showCheckboxes = !_showCheckboxes;
            });
          },
          icon: const Icon(Icons.edit),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddHabitPage())
              );
            },
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitLoaded) {
            _checkboxValues ??= List<bool>.filled(state.habits.length, false);
            return ListView.builder(
              itemCount: state.habits.length,
              itemBuilder: (context, index) {
                final habit = state.habits[index];
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.only(left: _showCheckboxes ? 0 : 50), // Adjust padding
                  child: ListTile(
                    title: Text(habit.title),
                    leading: _showCheckboxes
                      ? Checkbox(
                          value: _checkboxValues![index],
                          onChanged: (newValue) {
                            setState(() {
                              _checkboxValues![index] = newValue!;
                            });
                          }
                        )
                    : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPage(habit: habit,))
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is HabitError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
