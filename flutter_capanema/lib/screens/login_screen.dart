import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../components/custom_text_field.dart';
import '../components/login_button.dart';
import '../components/error_message.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ErrorMessage(message: errorMessage),
            CustomTextField(
              controller: emailController,
              label: 'Usuário',
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              label: 'Senha',
              obscureText: true,
            ),
            SizedBox(height: 20),
            LoginButton(
              authService: authService,
              emailController: emailController,
              passwordController: passwordController,
              onError: (String? error) {
                setState(() {
                  errorMessage = error;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
