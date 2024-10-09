import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import 'add_habit_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin  {

  List<bool>? _checkboxValues;
  late AnimationController _controller;
  int? _length;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  void _toggleCheckboxVisibility() {
    if (_controller.isCompleted) {
      _controller.reverse();
      _checkboxValues = List.filled(_length!, false);
    } else {
      _controller.forward();
    }
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
            _length ??= state.habits.length;
            return ListView.builder(
              itemCount: state.habits.length,
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
                          child: Text(state.habits[index].title)
                        )
                      ],
                    ),
                  ),
                );
              }
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
