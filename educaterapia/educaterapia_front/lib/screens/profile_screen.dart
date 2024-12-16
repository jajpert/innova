import 'package:flutter/material.dart';
import 'package:educaterapia/services/auth_service.dart';
import 'package:educaterapia/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    final AuthService authService = AuthService();
    await authService.logout();

    // Redireciona para a tela de login após o logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false; // Evita o comportamento padrão do botão "voltar"
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Perfil',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Retorna à tela anterior
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Substitua por uma URL real ou imagem local
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Nome do Usuário",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "email@example.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Sobre",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec purus nec leo tincidunt venenatis. Donec interdum, nulla a consequat sollicitudin, elit lacus mollis metus, vel aliquet lorem enim vel turpis.",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Configurações",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("Preferências"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text("Alterar senha"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Sair"),
                      onTap: () => _logout(context), // Chama a função de logout
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
