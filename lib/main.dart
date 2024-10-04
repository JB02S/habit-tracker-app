import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_bloc.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_state.dart';
import 'domain/use_cases/sign_in_use_case.dart';
import 'presentation/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SignInBloc()
        )
      ],
      child: MaterialApp(
        title: "Task manager",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SignInScreen(),
      ),
    );
  }
}


