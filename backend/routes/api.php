<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
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
Route::get("/unauthorized", function () {
    return response()->json(["message" => "unauthorized"], 403);
})->name("unauthorized");

Route::middleware("auth:api")->group(function () {
    Route::prefix("/profile")->group(function () {
        Route::get("/me", [UserController::class, "getMe"]);
        Route::put("/", [UserController::class, "edit"]);
    });

    Route::prefix("/post")->group(function () {
        Route::get("/", [PostController::class, "get"]);
        Route::get("/{id}", [PostController::class, "getOne"]);
        Route::post("/", [PostController::class, "create"]);
        Route::delete("/{id}", [PostController::class, "delete"]);
        Route::put("/{id}", [PostController::class, "edit"]);
    });

    Route::prefix("/berita")->group(function () {
        Route::get("/", [\App\Http\Controllers\BeritaController::class, "get"]);
        Route::get("/{id}", [\App\Http\Controllers\BeritaController::class, "getOne"]);
        Route::post("/", [\App\Http\Controllers\BeritaController::class, "create"]);
    });

    Route::prefix("/produk")->group(function () {
        Route::get("/", [\App\Http\Controllers\ProdukController::class, "get"]);
        Route::get("/{id}", [\App\Http\Controllers\ProdukController::class, "getOne"]);
        Route::post("/", [\App\Http\Controllers\ProdukController::class, "create"]);
        Route::put("/{id}", [\App\Http\Controllers\ProdukController::class, "edit"]);
        Route::delete("/{id}", [\App\Http\Controllers\ProdukController::class, "delete"]);
    });

    Route::prefix("/history")->group(function () {
        Route::prefix("/produk")->group(function () {
            Route::get("/", [\App\Http\Controllers\ProdukController::class, "getHistory"]);
            Route::get("/{id}", [\App\Http\Controllers\ProdukController::class, "getHistoryOne"]);
        });
    });

    Route::prefix("/alamat")->group(function () {
        Route::get("/", [\App\Http\Controllers\PesananController::class, "getAlamat"]);
        Route::post("/", [\App\Http\Controllers\PesananController::class, "createAlamat"]);
    });

    Route::prefix("/pesanan")->group(function () {
        Route::get("/", [\App\Http\Controllers\PesananController::class, "get"]);
        Route::get("/{id}", [\App\Http\Controllers\PesananController::class, "getOne"]);
        Route::post("/", [\App\Http\Controllers\PesananController::class, "create"]);
    });
});
