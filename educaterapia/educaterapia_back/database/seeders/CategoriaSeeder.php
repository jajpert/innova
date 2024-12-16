<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Categoria;

class CategoriaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categorias = [
            [
                'nome' => 'Eletrônicos',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
            ],
            [
                'nome' => 'Moda',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
            ],
            [
                'nome' => 'Livros',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
            ],
            [
                'nome' => 'Beleza',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
            ],
            [
                'nome' => 'Esportes',
                'caminho_imagem' => '../assets/imagens/menina.jpeg',
            ],
        ];

        foreach ($categorias as $categoria) {
            Categoria::create($categoria);
        }

    }
}
