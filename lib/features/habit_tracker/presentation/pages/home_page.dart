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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleCheckboxVisibility() {
    if (_controller.isCompleted) {
      _controller.reverse();
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
            return Row(
              children: [
                SizedBox(
                  width: 100,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-1, 0),
                      end: Offset(-0.2, 0)
                    ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut
                    )),
                    child: ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: false,
                          onChanged: (bool? value) {},
                        );
                      },
                    ),
                  )
                ),
                Expanded(
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-0.3, 0),
                      end: Offset(-0.1, 0)
                    ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut
                    )),
                    child: ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.habits[index].title),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
            // return ListView.builder(
            //   itemCount: state.habits.length,
            //   itemBuilder: (context, index) {
            //     final habit = state.habits[index];
            //     return ListTile(
            //       title: Text(habit.title),
            //       leading: _showCheckboxes
            //         ? Checkbox(
            //             value: _checkboxValues![index],
            //             onChanged: (newValue) {
            //               setState(() {
            //                 _checkboxValues![index] = newValue!;
            //               });
            //             }
            //           )
            //       : null,
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => DetailPage(habit: habit,))
            //         );
            //       },
            //     );
            //   },
            // );
          } else if (state is HabitError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
