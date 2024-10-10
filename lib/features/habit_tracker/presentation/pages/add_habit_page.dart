import 'package:flutter/material.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_event.dart';
import 'package:provider/provider.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  String _title = '';

  @override
  Widget build(BuildContext context) {
    final habitBloc = context.read<HabitBloc>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add habit")
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            const Text("Habit title"),
            TextFormField(
              validator: (String? value) {
                return (value == null || value.isEmpty) ? 'Please enter a value' : null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(height: 60,),
            const Text("Habit description"),
            TextFormField(
              validator: (String? value) {
                return (value == null || value.isEmpty) ? 'Please enter a value' : null;
              },
              onSaved: (value) {
                _description = value!;
              },

            ),
            SizedBox(height: 60,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    habitBloc.add(AddHabitEvent(HabitEntity(title: _title, description: _description)));
                    Navigator.pop(context);
                  }
                },
                child: Text("Add")
              ),
            ),
          ],
        ),
      ),
    );
  }
}