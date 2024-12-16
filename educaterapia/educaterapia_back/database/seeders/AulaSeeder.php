<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Aula;
use App\Models\Curso;

class AulaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $cursos = Curso::all();
        if ($cursos->isEmpty()) {
            $cursos = Curso::factory(3)->create();
        }

        $aulas = [
            [
                'nome' => 'Introdução ao Curso',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
            [
                'nome' => 'Conceitos Básicos',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
            [
                'nome' => 'Prática Avançada',
                'caminho_video' => '../assets/videos/video.mp4',
            ],
        ];

        foreach ($cursos as $curso) {
            foreach ($aulas as $aula) {
                Aula::create(array_merge($aula, [
                    'curso_id' => $curso->id,
                ]));
            }
        }
    }
}
