<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request) {
        $fields = $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'telefone' => 'required',
            'password' => 'required|confirmed'
        ]);

        $user = User::create($fields);

        $token = $user->createToken($request->name);

        return [
            'user' => $user,
            'token' => $token->plainTextToken
        ];
    }

    public function login(Request $request)
{
    $request->validate([
        'email' => 'required|email|exists:users',
        'password' => 'required'
    ]);

    $user = User::where('email', $request->email)->first();

    if (!$user || !Hash::check($request->password, $user->password)) {
        return response()->json([
            'errors' => [
                'email' => ['The provided credentials are incorrect.']
            ]
        ], 401);
    }

    $token = $user->createToken($user->name);

    return response()->json([
        'user' => $user,
        'token' => $token->plainTextToken
    ], 200);
}


    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();

        return [
            'message' => 'You are logged out.'
        ];
    }
}
