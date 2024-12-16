<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Curso;
use App\Models\Categoria;

class CursoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $categorias = Categoria::all();
        if ($categorias->isEmpty()) {
            $categorias = Categoria::factory(3)->create();
        }


        $cursos = [
            [
                'nome' => 'Introdução à Programação',
                'descricao' => 'Aprenda os fundamentos da programação com este curso introdutório.',
                'nivel' => 'Básico',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
            [
                'nome' => 'Design Gráfico para Iniciantes',
                'descricao' => 'Explore o mundo do design gráfico com este curso prático.',
                'nivel' => 'Intermediário',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
            [
                'nome' => 'Avançado em Machine Learning',
                'descricao' => 'Domine técnicas avançadas em Machine Learning e IA.',
                'nivel' => 'Avançado',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
        ];

        foreach ($cursos as $curso) {
            Curso::create(array_merge($curso, [
                'categoria_id' => $categorias->random()->id,
            ]));
        }
    }
}
