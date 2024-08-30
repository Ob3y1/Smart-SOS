<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\GroupController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\OtpController;
use App\Http\Controllers\ComplaintController;

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
Route::post('SendOtp', [OtpController::class, 'SendOtp']);
Route::post('verifyOtpSignUp', [OtpController::class, 'verifyOtpSignUp']);
Route::post('loginusers', [AuthController::class, 'loginusers']);
Route::post('logingroups', [AuthController::class, 'logingroups']);

Route::middleware('auth:sanctum')->group(function () {
// users
    Route::get('/profile', [UserController::class, 'show']);
    Route::put('/profile', [UserController::class, 'update']);
    Route::post('logoutusers', [UserController::class, 'logoutusers']);
    Route::post('homeuser', [UserController::class, 'homeuser']);
    Route::get('getrequest/{id}', [UserController::class, 'getrequests']);
    Route::get('/complaints', [ComplaintController::class, 'index']);
    Route::post('/complaints', [ComplaintController::class, 'store']);

//end users
// groups
    Route::get('get_request_notification', [GroupController::class, 'get_request_notification']);
    Route::get('agree/{id}', [GroupController::class, 'agree']);
    Route::get('refuse/{id}', [GroupController::class, 'refuse']);
    Route::get('change_status', [GroupController::class, 'change_status']);
    Route::get('show_info/{id}', [GroupController::class, 'show_info']);
    Route::get('support/{id}', [GroupController::class, 'support']);
    Route::get('home', [GroupController::class, 'home']);
    Route::post('finish', [GroupController::class, 'finish']);
    Route::post('logoutgroups', [GroupController::class, 'logout']);
//end groups
});

