<?php

namespace Database\Factories;

use App\Models\Aula;
use App\Models\Curso;
use Illuminate\Database\Eloquent\Factories\Factory;

class AulaFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Aula::class;

    public function definition(): array
    {
        return [
            'nome' => $this->faker->sentence(3),
            'caminho_video' => 'assets/videos/video.mp4',
            'curso_id' => Curso::inRandomOrder()->first()->id ?? Curso::factory()->create()->id,
        ];
    }
}
