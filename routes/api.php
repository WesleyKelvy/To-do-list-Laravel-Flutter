<?php

// use Illuminate\Http\Request;
// use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
    //     return $request->user();
    // })->middleware('auth:sanctum');


use App\Http\Controllers\TaskController;
Route::apiResource('tasks', TaskController::class);
