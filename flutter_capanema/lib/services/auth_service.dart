import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'http://localhost:8000/api';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'];

        // Salvar o token
        await storage.write(key: 'token', value: token);
        return null; // Login bem-sucedido, sem mensagem de erro
      } else if (response.statusCode == 422) {
        // Erro de validação
        final data = json.decode(response.body);
        if (data['errors'] != null && data['errors']['email'] != null) {
          return data['errors']['email'][0]; // Mensagem de erro específica
        }
      } else if (response.statusCode == 404) {
        // Usuário não encontrado
        final data = json.decode(response.body);
        if (data['message'] != null) {
          return data['message']; // Retorna a mensagem de erro
        }
      }
      return 'Erro ao fazer login. Verifique suas credenciais e tente novamente.';
    } catch (e) {
      print('Erro durante o login: $e');
      return 'Erro de conexão. Tente novamente mais tarde.';
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token'); // Remover o token ao sair
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token'); // Obter o token armazenado
  }
}
