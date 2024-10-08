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
            return ListView.builder(
              itemCount: state.habits.length,
              itemBuilder: (context, index) {
                final habit = state.habits[index];
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: Card(
                    child: ListTile(
                      title: Text(habit.title),
                      leading: _showCheckboxes
                        ? Checkbox(
                            value: false,
                            onChanged: (newValue) {
                              throw UnimplementedError();
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
