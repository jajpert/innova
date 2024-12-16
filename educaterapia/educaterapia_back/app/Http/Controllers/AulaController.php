<?php

namespace App\Http\Controllers;

use App\Models\Aula;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class AulaController extends Controller implements HasMiddleware
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
        return Aula::all();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'curso_id' => 'required',
            'nome' => 'required',
            'caminho_video' => 'required',
        ]);

        $aula = $request->user()->aulas()->create($fields);

        return $aula;
    }

    /**
     * Display the specified resource.
     */
    public function show(Aula $aula)
    {
        return $aula;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Aula $aula)
    {
        Gate::authorized('modify', $aula);

        $request->validate([
            'curso_id' => 'required',
            'nome' => 'required',
            'caminho_video' => 'required',
        ]);

        $aula->update($fields);

        return $aula;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Aula $aula)
    {
        Gate::authorized('modify', $aula);

        $aula->delete();

        return ['message' => 'Aula deleted successfully'];
    }
}
