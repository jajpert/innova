import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../screens/menu_screen.dart';

class LoginButton extends StatelessWidget {
  final AuthService authService;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String?) onError;

  const LoginButton({
    Key? key,
    required this.authService,
    required this.emailController,
    required this.passwordController,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final String? error = await authService.login(
          emailController.text,
          passwordController.text,
        );

        if (error == null) {
          // Login bem-sucedido
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MenuScreen()),
          );
        } else {
          // Exibe mensagem de erro
          onError(error);
        }
      },
      child: Text('Entrar'),
    );
  }
}
