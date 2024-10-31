import 'package:flutter/material.dart';
import 'dart:async'; // Para o temporizador

void main() {
  runApp(CapanemaFlagApp());
}

class CapanemaFlagApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capanema Flag App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Definimos a SplashScreen como a tela inicial
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Definir um timer de 5 segundos antes de ir para o carrossel
    Timer(Duration(seconds: 5), () {
      // Após 5 segundos, navegar para o carrossel
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CarouselScreen(), // Muda para o carrossel
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/image/image.png', // Usando a imagem local
          fit: BoxFit.cover,
          width: 500, // Definir largura da imagem
          height: 300, // Definir altura da imagem
        ),
      ),
    );
  }
}

// Tela de Carrossel
class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao Capanema'),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              _buildPageContent(
                title: 'Página 1',
                content:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              _buildPageContent(
                title: 'Página 2',
                content:
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildLastPage(context),
            ],
          ),
          // Setas de navegação
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _goToPreviousPage,
              color: _currentPage > 0
                  ? Colors.blue
                  : Colors.grey, // Desabilita se for a primeira página
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: _goToNextPage,
              color: _currentPage < 2
                  ? Colors.blue
                  : Colors.grey, // Desabilita se for a última página
            ),
          ),
        ],
      ),
    );
  }

  // Páginas com conteúdo
  Widget _buildPageContent({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            content,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Última página com o botão de Login
  Widget _buildLastPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Última Página',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Clique no botão abaixo para fazer login.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      LoginScreen(), // Navega para a tela de login
                ),
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

// Tela de Login Simples
class LoginScreen extends StatelessWidget {
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        MenuScreen(), // Navega para o Menu em Grid
                  ),
                );
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

// Menu com Grid e BottomNavigationBar
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0; // Índice da tela selecionada

  // Lista de widgets para cada tela
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SettingsScreen(),
    ProfileScreen(),
    HelpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: _selectedIndex == 0
          ? _buildGrid()
          : _widgetOptions[
              _selectedIndex], // Exibe o grid ou a tela selecionada
      // BottomNavigationBar para navegação
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Ajuda',
          ),
        ],
        currentIndex: _selectedIndex, // Índice selecionado
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.lightBlueAccent,
        onTap: _onItemTapped, // Função ao tocar no item
      ),
    );
  }

  // Método para construir o grid de opções
  Widget _buildGrid() {
    return GridView.count(
      crossAxisCount: 2, // Número de colunas
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        _buildGridTile('Início', Icons.home, () {
          setState(() {
            _selectedIndex = 0; // Mudar para a tela inicial
          });
        }),
        _buildGridTile('Configurações', Icons.settings, () {
          setState(() {
            _selectedIndex = 1; // Mudar para a tela de configurações
          });
        }),
        _buildGridTile('Perfil', Icons.person, () {
          setState(() {
            _selectedIndex = 2; // Mudar para a tela de perfil
          });
        }),
        _buildGridTile('Ajuda', Icons.help, () {
          setState(() {
            _selectedIndex = 3; // Mudar para a tela de ajuda
          });
        }),
      ],
    );
  }

  // Método para criar cada tile do grid
  Widget _buildGridTile(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 40),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela para Início
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bem-vindo à página inicial!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela para Configurações
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Aqui estão suas configurações',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela para Perfil
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Aqui está seu perfil',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela para Ajuda
class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Aqui você encontra ajuda',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
