<?php

namespace App\Http\Controllers;

use App\Models\Curso;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class CursoController extends Controller implements HasMiddleware
{
    public static function middleware()
    {
        return [
            new Middleware('auth:sanctum', except: ['index', 'show'])
        ];
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $cursos = Curso::withCount('aulas')->get();

        $cursos->transform(function ($curso) {
            $curso->qtd_aulas = $curso->aulas_count ?? 0;
            unset($curso->aulas_count);
            return $curso;
        });

        return $cursos;
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'categoria_id' => 'required',
            'nome' => 'required',
            'descricao' => 'required',
            'nivel' => 'required',
            'caminho_imagem' => 'required',
            'caminho_video' => 'required'
        ]);

        $curso = $request->user()->cursos()->create($fields);

        return $curso;
    }

    /**
     * Display the specified resource.
     */
    public function show(Curso $curso)
    {
        return $curso;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Curso $curso)
    {
        Gate::authorized('modify', $curso);

        $request->validate([
            'categoria_id' => 'required',
            'nome' => 'required',
            'descricao' => 'required',
            'nivel' => 'required',
            'caminho_imagem' => 'required',
            'caminho_video' => 'required'
        ]);

        $curso->update($fields);

        return $curso;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Curso $curso)
    {
        Gate::authorized('modify', $curso);

        $curso->delete();

        return ['message' => 'Curso deleted successfully'];
    }
}
