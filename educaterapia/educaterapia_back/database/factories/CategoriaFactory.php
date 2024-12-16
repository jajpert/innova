<?php

namespace Database\Factories;

use App\Models\Categoria;
use Illuminate\Database\Eloquent\Factories\Factory;

class CategoriaFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Categoria::class;

    public function definition(): array
    {
        return [
            'nome' => $this->faker->word(),
            'caminho_imagem' => 'assets/imagens/menina.jpeg',
        ];
    }
}
