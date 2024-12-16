<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Curso extends Model
{
    /** @use HasFactory<\Database\Factories\CursoFactory> */
    use HasFactory;

    protected $fillable = [
        'categoria_id',
        'nome',
        'descricao',
        'nivel',
        'caminho_imagem',
        'caminho_video'
    ];

    public function aulas()
    {
        return $this->hasMany(Aula::class);
    }
}
