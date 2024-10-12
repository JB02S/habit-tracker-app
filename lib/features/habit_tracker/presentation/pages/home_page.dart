import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_event.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import '../../../../injection_container.dart';
import 'add_habit_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin  {

  bool _deleteMode = false;
  List<bool>? _checkboxValues;
  late AnimationController _controller;
  int _length = 0;

  void _toggleCheckboxVisibility() {
    if (_controller.isCompleted) {
      _controller.reverse();
      _checkboxValues = List.filled(_length, false);
    } else {
      _controller.forward();
    }
  }

  void _toggleDeleteMode() {
    _deleteMode = !_deleteMode;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Habits",),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _toggleCheckboxVisibility();
              _toggleDeleteMode();
            });
          },
          icon: const Icon(Icons.edit),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {

              final habits = await locater<HabitRepository>().getHabits();

              if (_deleteMode) {
                for (int idx = 0; idx < _length; idx++) {
                  if (_checkboxValues![idx] == true) {
                    context.read<HabitBloc>().add(DeleteHabitEvent(habits[idx]));
                  }
                }

                setState(() {
                  _toggleCheckboxVisibility();
                  _toggleDeleteMode();
                });

              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddHabitPage()),
                );
              }
            },
            icon: Icon(_deleteMode ? Icons.delete : Icons.add)
          ),
        ],
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {

            return const Center(child: CircularProgressIndicator());

          } else if (state is HabitLoaded) {
            if (_length != state.habits.length) {
              _length = state.habits.length;
              _checkboxValues = List<bool>.filled(_length, false);
            }
            if (_length == 0) {
              return Center(child: Text("You have no habits"));
            } else {
              return ListView.builder(
                  itemCount: _length,
                  itemBuilder: (context, index) {
                    return SlideTransition(
                      position: Tween<Offset>(
                          begin: Offset(-0.13, 0),
                          end: Offset(0, 0)
                      ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOut
                      )),
                      child: ListTile(
                        title: Row(
                          children: [
                            Checkbox(
                              value: _checkboxValues![index],
                              onChanged: (value) {
                                setState(() {
                                  _checkboxValues![index] = !_checkboxValues![index];
                                });
                              }
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Text(state.habits[index].title),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DetailPage(habit: state.habits[index]))
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          } else if (state is HabitError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
