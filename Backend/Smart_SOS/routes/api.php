<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\GroupController;
use App\Http\Controllers\UserController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('registrationusers', [AuthController::class, 'registrationusers']); 
Route::post('loginusers', [AuthController::class, 'loginusers']);
Route::post('logingroups', [AuthController::class, 'logingroups']);
Route::middleware('auth:sanctum')->group(function () {
// users
    Route::get('/profile', [UserController::class, 'show']);
    Route::put('/profile', [UserController::class, 'update']);
    Route::post('logoutusers', [UserController::class, 'logoutusers']);
//end users
// groups
    Route::post('logoutgroups', [GroupController::class, 'logout']);
//end groups
});

