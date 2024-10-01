import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});
  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButtonBuilder(
              text: 'Get going with Email',
              icon: Icons.email,
              onPressed: () {
                _showButtonPressDialog(context, 'Email');
              },
              backgroundColor: Colors.blueGrey[700]!,
              width: 220.0,
            ),
            const Divider(),
            SignInButton(
              Buttons.google,
              onPressed: () {
                _showButtonPressDialog(context, 'Google');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.googleDark,
              onPressed: () {
                _showButtonPressDialog(context, 'Google (dark)');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.facebookNew,
              onPressed: () {
                _showButtonPressDialog(context, 'FacebookNew');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.apple,
              onPressed: () {
                _showButtonPressDialog(context, 'Apple');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.gitHub,
              text: 'Sign up with GitHub',
              onPressed: () {
                _showButtonPressDialog(context, 'Github');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.microsoft,
              text: 'Sign up with Microsoft ',
              onPressed: () {
                _showButtonPressDialog(context, 'Microsoft ');
              },
            ),
            const Divider(),
            SignInButton(
              Buttons.twitter,
              text: 'Use Twitter',
              onPressed: () {
                _showButtonPressDialog(context, 'Twitter');
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(
                  Buttons.linkedIn,
                  mini: true,
                  onPressed: () {
                    _showButtonPressDialog(context, 'LinkedIn (mini)');
                  },
                ),
                SignInButton(
                  Buttons.tumblr,
                  mini: true,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Tumblr (mini)');
                  },
                ),
                SignInButton(
                  Buttons.facebook,
                  mini: true,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Facebook (mini)');
                  },
                ),
                SignInButtonBuilder(
                  icon: Icons.email,
                  text: 'Ignored for mini button',
                  mini: true,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Email (mini)');
                  },
                  backgroundColor: Colors.cyan,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}