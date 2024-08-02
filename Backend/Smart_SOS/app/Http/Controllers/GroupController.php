<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class groupController extends Controller
{
    public function logout(Request $request)
     {
        $request->user()->currentAccessToken()->delete();
         return response()->json([
             'message' => 'Logged out successfully'
         ]);
     }
}
