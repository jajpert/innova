<?php

namespace Database\Factories;

use App\Models\Curso;
use App\Models\Categoria;
use Illuminate\Database\Eloquent\Factories\Factory;

class CursoFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Curso::class;

    public function definition(): array
    {
        return [
            'nome' => $this->faker->sentence(3),
            'descricao' => $this->faker->paragraph(),
            'nivel' => $this->faker->randomElement(['Básico', 'Intermediário', 'Avançado']),
            'caminho_imagem' => 'assets/imagens/menina.jpeg',
            'caminho_video' => 'assets/videos/video.mp4',
            'categoria_id' => Categoria::inRandomOrder()->first()->id ?? Categoria::factory()->create()->id,
        ];
    }
}
