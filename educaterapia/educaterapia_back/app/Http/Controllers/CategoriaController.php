<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class CategoriaController extends Controller implements HasMiddleware
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

        $categorias = Categoria::withCount('cursos')->get();

        $categorias->transform(function ($categoria) {
            $categoria->qtd_cursos = $categoria->cursos_count ?? 0;
            unset($categoria->cursos_count);
            return $categoria;
        });

        return $categorias;
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nome' => 'required',
            'caminho_imagem' => 'required',
        ]);

        $categoria = $request->user()->categorias()->create($fields);

        return $categoria;
    }

    /**
     * Display the specified resource.
     */
    public function show(Categoria $categoria)
    {
        return $categoria;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Categoria $categoria)
    {
        Gate::authorized('modify', $categoria);

        $request->validate([
            'nome' => 'required',
            'caminho_imagem' => 'required',
        ]);

        $categoria->update($fields);

        return $categoria;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Categoria $categoria)
    {
        Gate::authorized('modify', $categoria);

        $categoria->delete();

        return ['message' => 'Categoria deleted successfully'];
    }
}
