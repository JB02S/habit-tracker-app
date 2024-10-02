import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_event.dart';

import '../blocs/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  // Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validator for email field
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validator for password field
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Function to handle form submission
  void _onSignInButtonPressed() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      // Dispatch the SignIn event to the BLoC with email and password
      context.read<SignInBloc>().add(
        SignInButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              // Email Input Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _emailValidator, // Email validation logic
                keyboardType: TextInputType.emailAddress,
              ),

            const SizedBox(height: 16.0),

            // Password Input Field
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: _passwordValidator, // Password validation logic
              obscureText: true, // Hide the password text
            ),

            const SizedBox(height: 16.0),

            // Sign In Button
            ElevatedButton(
              onPressed: _onSignInButtonPressed, // Call the sign-in function
              child: const Text('Sign In'),
            )
            ],
          ),
        ),
      ),
    );
  }
}