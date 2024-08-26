<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\GroupController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\OtpController;

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
Route::post('createadmin', [AuthController::class, 'createadmin']);

Route::post('SendOtp', [OtpController::class, 'SendOtp']);
Route::post('verifyOtpSignUp', [OtpController::class, 'verifyOtpSignUp']);
Route::post('loginusers', [AuthController::class, 'loginusers']);
Route::post('logingroups', [AuthController::class, 'logingroups']);
// Route::post('location', [UserController::class, 'locations']);


Route::post('location1', [UserController::class, 'locations1']);

Route::middleware('auth:sanctum')->group(function () {
// users
Route::post('l', [UserController::class, 'l']);
    Route::get('/profile', [UserController::class, 'show']);
    Route::put('/profile', [UserController::class, 'update']);
    Route::post('logoutusers', [UserController::class, 'logoutusers']);
    Route::post('homeuser', [UserController::class, 'homeuser']);
    Route::get('status/{id}', [UserController::class, 'getStatus']);
    Route::get('getrequest/{id}', [UserController::class, 'getrequests']);
    Route::post('sendnote', [UserController::class, 'sendnote']);

//end users
// groups
    Route::get('j/{id}', [GroupController::class, 'j']);


    Route::get('get_request_notification', [GroupController::class, 'get_request_notification']);
    Route::get('agree/{id}', [GroupController::class, 'agree']);
    Route::get('refuse/{id}', [GroupController::class, 'refuse']);
    Route::get('change_status', [GroupController::class, 'change_status']);
    Route::get('show_info/{id}', [GroupController::class, 'show_info']);
    Route::post('finish', [GroupController::class, 'finish']);
    Route::get('home', [GroupController::class, 'home']);
    Route::post('logoutgroups', [GroupController::class, 'logout']);
//end groups
});