<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Task::all();  // Retorna todas as tarefas
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $task = Task::create($request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'required|boolean',
        ]));

        return response()->json($task, 201);  // Retorna a tarefa criada com status 201 (criado)
    }


    /**
     * Display the specified resource. (string $id)
     */ 
    public function show($id)
    {
        $task = Task::findOrFail($id);  // Procura a tarefa ou retorna 404 se não for encontrada
        return $task;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);  // Encontra a tarefa ou retorna 404 se não for encontrada

        $task->update($request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'required|boolean',
        ]));

        return response()->json($task, 200);  // Retorna a tarefa atualizada com status 200 (sucesso)
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $task = Task::findOrFail($id);  // Procura a tarefa ou retorna 404 se não for encontrada
        $task->delete();  // Deleta a tarefa

        return response()->json(null, 204);  // Retorna status 204 (sem conteúdo) após a exclusão
    }

}
