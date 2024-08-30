<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [AuthController::class, 'showloginadmin'])->name('login');
Route::post('post-login', [AuthController::class, 'postLogin'])->name('login.post'); 
Route::get('logout', [AdminController::class, 'logout'])->name('logout');
Route::get('homeadmin', [AdminController::class, 'homeadmin'])->name('homeadmin');
Route::get('false', [AdminController::class, 'false'])->name('false');
Route::get('requests', [AdminController::class, 'requests'])->name('requests');
Route::get('ShowSites', [AdminController::class, 'ShowSites'])->name('ShowSites');
Route::get('AddSites', [AdminController::class, 'AddSites'])->name('AddSites');
Route::post('AddSites', [AdminController::class, 'AddSites1'])->name('AddSites');
Route::get('showsitegroup/{id}', [AdminController::class, 'showsitegroup'])->name('showsitegroup');
Route::get('ShowCo', [AdminController::class, 'ShowCo'])->name('ShowCo');
Route::post('ShowCo', [AdminController::class, 'ShowCo1'])->name('ShowCo');
Route::get('profile', [AdminController::class, 'profile'])->name('profile');
Route::put('profile', [AdminController::class, 'profile1'])->name('postprofile');
Route::get('AddGroups', [AdminController::class, 'AddGroups']);
Route::post('AddGroups', [AdminController::class, 'store']);
Route::get('ShowGroups', [AdminController::class, 'index']);
Route::get('ShowGroups1/{job}', [AdminController::class, 'index1']);
Route::get('simple', [AdminController::class,'simple'])->name('simple_search');
Route::get('showdetails/{id}', [AdminController::class, 'details1']);
Route::get('updategroup1/{id}', [AdminController::class, 'updateGroup1']);
Route::put('updategroup2/{id}', [AdminController::class, 'updateGroup2']);
Route::post('/delete1', [AdminController::class, 'deleteGroup1'])->name('delete.group1');
Route::post('/delete2', [AdminController::class, 'deleteGroup2'])->name('delete.group2');


