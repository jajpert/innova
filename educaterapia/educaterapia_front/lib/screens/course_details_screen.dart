import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class CourseDetailsScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailsScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late Future<Course> _course;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _course = fetchCourseDetails(widget.courseId);
  }

  Future<Course> fetchCourseDetails(int id) async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/cursos/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Course.fromJson(data);
    } else {
      throw Exception('Failed to load course details');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Course>(
        future: _course,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Curso não encontrado.'));
          }

          final course = snapshot.data!;

          // Inicializar o controlador do vídeo
          _videoPlayerController = VideoPlayerController.network(course.videoPath)
            ..initialize().then((_) {
              setState(() {}); // Atualiza para refletir o estado do vídeo
            });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Espaço branco com seta para voltar
                Container(
                  color: Colors.white,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 24,
                        ),
                        tooltip: 'Voltar',
                      ),
                    ],
                  ),
                ),
                // Player de vídeo
                if (_videoPlayerController != null &&
                    _videoPlayerController!.value.isInitialized)
                  AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_videoPlayerController!),
                        if (!_videoPlayerController!.value.isPlaying)
                          IconButton(
                            icon: const Icon(
                              Icons.play_circle_fill,
                              size: 64,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoPlayerController!.play();
                              });
                            },
                          ),
                        if (_videoPlayerController!.value.isPlaying)
                          IconButton(
                            icon: const Icon(
                              Icons.pause_circle_filled,
                              size: 64,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoPlayerController!.pause();
                              });
                            },
                          ),
                      ],
                    ),
                  )
                else
                  Container(
                    height: 200,
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                // Descrição do curso
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tabs (Resumo, Aulas, Cursos Similares)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Lógica para aba Resumo
                        },
                        child: const Text(
                          'Resumo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Lógica para aba Aulas
                        },
                        child: Text(
                          'Aulas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Lógica para aba Cursos Similares
                        },
                        child: Text(
                          'Cursos Similares',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Conteúdo Resumo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.timer, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("6 Horas"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.verified, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Certificado ao finalizar"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.bar_chart, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Iniciante"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Botão iniciar curso
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para iniciar o curso
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Iniciar Curso",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Course {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String level;
  final String imagePath;
  final String videoPath;

  Course({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.level,
    required this.imagePath,
    required this.videoPath,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      categoryId: json['categoria_id'],
      name: json['nome'],
      description: json['descricao'],
      level: json['nivel'],
      imagePath: json['caminho_imagem'],
      videoPath: json['caminho_video'],
    );
  }
}
