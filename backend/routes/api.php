<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ShopController;
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
        Route::get("/{id}", [UserController::class, "getByID"]);
        Route::put("/", [UserController::class, "edit"]);
    });

    Route::prefix("/post")->group(function () {
        Route::get("/", [PostController::class, "get"]);
        Route::get("/{id}", [PostController::class, "getOne"]);
        Route::get("/k/{keyword}", [PostController::class, "getByKeyword"]);
        Route::post("/", [PostController::class, "create"]);
        Route::delete("/{id}", [PostController::class, "delete"]);
        Route::put("/{id}", [PostController::class, "edit"]);
    });

    Route::prefix("/shop")->group(function () {
       Route::get("/", [ShopController::class, "getAll"]);
       Route::get("/{id}", [ShopController::class, "getByID"]);
       Route::get("/user/{userId}", [ShopController::class, "getByUserID"]);
       Route::post("/", [ShopController::class, "create"]);
       Route::put("/", [ShopController::class, "edit"]);
    });

    Route::prefix("/comment")->group(function () {
       Route::get("/{postId}", [PostController::class, "getComment"]);
       Route::post("/{postId}", [PostController::class, "postComment"]);
    });

    Route::prefix("/news")->group(function () {
        Route::get("/", [NewsController::class, "get"]);
        Route::get("/{id}", [NewsController::class, "getOne"]);
        Route::post("/", [NewsController::class, "create"]);
    });

    Route::prefix("/product")->group(function () {
        Route::get("/", [ProductController::class, "get"]);
        Route::get("/{id}", [ProductController::class, "getOne"]);
        Route::get("/k/{keyword}", [ProductController::class, "getByKeyword"]);
        Route::post("/", [ProductController::class, "create"]);
        Route::put("/{id}", [ProductController::class, "edit"]);
        Route::delete("/{id}", [ProductController::class, "delete"]);
    });

    Route::prefix("/history")->group(function () {
        Route::prefix("/product")->group(function () {
            Route::get("/", [ProductController::class, "getHistory"]);
            Route::get("/{id}", [ProductController::class, "getHistoryOne"]);
        });
    });

    Route::prefix("/order")->group(function () {
        Route::get("/", [OrderController::class, "get"]);
        Route::get("/shop", [OrderController::class, "getShop"]);
        Route::get("/{id}", [OrderController::class, "getOne"]);
        Route::post("/", [OrderController::class, "create"]);
    });
});
