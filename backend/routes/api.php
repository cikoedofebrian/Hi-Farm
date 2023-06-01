<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PostController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post("/login", [AuthController::class, "login"]);
Route::post("/register", [AuthController::class, "register"]);

Route::middleware("auth:api")->group(function () {
    Route::get("/post", [PostController::class, "get"]);
    Route::get("/post/{id}", [PostController::class, "getOne"]);
    Route::post("/post", [PostController::class, "create"]);
    Route::delete("/post/{id}", [PostController::class, "delete"]);
    Route::put("/post/{id}", [PostController::class, "edit"]);

    Route::prefix("/berita")->group(function () {
        Route::get("/", [\App\Http\Controllers\BeritaController::class, "get"]);
        Route::get("/{id}", [\App\Http\Controllers\BeritaController::class, "getOne"]);
        Route::post("/", [\App\Http\Controllers\BeritaController::class, "create"]);
    });
});
