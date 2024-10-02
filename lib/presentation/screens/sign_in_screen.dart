import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_event.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_bloc.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_state.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

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

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: _emailValidator, // Email validation logic
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: _passwordValidator, // Password validation logic
      obscureText: true, // Hide the password text
    );
  }

  Widget _signInButton() {
    return ElevatedButton(
      onPressed: _onSignInButtonPressed, // Call the sign-in function
      child: const Text('Sign In'),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _emailField(),
          _passwordField(),
          _signInButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loginForm()
      ),
    );
  }
}