import 'package:educaterapia/screens/premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'payment_screen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _registrarUsuario() async {
    final nome = _nomeController.text.trim();
    final telefone = _telefoneController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (nome.isEmpty || telefone.isEmpty || email.isEmpty || senha.isEmpty) {
      _mostrarMensagem("Por favor, preencha todos os campos.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      final response = await http.post(
        Uri.parse('http://localhost:8000/api/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nome,
          'email': email,
          'telefone': telefone,
          'password': senha,
          'password_confirmation': senha
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _mostrarMensagem("Registro realizado com sucesso!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PaymentScreen()),
        );
      } else {
        final mensagemErro = jsonDecode(response.body)['error'] ?? "Erro desconhecido.";
        _mostrarMensagem("Falha no registro: $mensagemErro");
      }
    } catch (e) {
      _mostrarMensagem("Erro ao conectar-se ao servidor: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PremiumScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Registro",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _nomeController,
              label: "Nome Completo",
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _telefoneController,
              label: "Telefone",
              icon: Icons.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: "Email",
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _senhaController,
              label: "Senha",
              icon: Icons.lock,
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _registrarUsuario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D72F6),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Registrar",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Já tenho uma conta. "),
                  GestureDetector(
                    onTap: () {
                      // Implementar navegação para a tela de login
                    },
                    child: const Text(
                      "Entre aqui",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            suffixIcon: suffixIcon,
            border: const UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
