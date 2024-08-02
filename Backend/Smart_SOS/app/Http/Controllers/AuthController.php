<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Session;
use App\Models\User;
use App\Models\Group;
use Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
   
    // users
    public function registrationusers(Request $request)
    {  
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'phone_number' => 'required|unique:users,phone_number|max:10',
            'date_of_birth' => 'required',
            'gender' => 'required|string|in:male,female',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $user = User::create([
            'name' => $request->name,
            'phone_number' => $request->phone_number,
            'date_of_birth' => $request->date_of_birth,
            'gender' => $request->gender,
            'password' => Hash::make($request->password),
        ]);
    
        return response()->json([
            'success' => true,
            'message' => 'Account created successfully. Please log in.',
        ], 201);   
     }
    

     public function loginusers(Request $request)
     {
        $validator = Validator::make($request->all(),[
        'phone_number' => 'required',
        'password' => 'required',
    ]);
    if ($validator->fails()) {
        return response()->json(['errors' => $validator->errors()], 422);
    }
         $credentials = $request->only('phone_number', 'password');
     
         $user = User::where('phone_number', $request->phone_number)->first();
     
         if ($user && Hash::check($request->password, $user->password)) {
             $token = $user->createToken('user-token')->plainTextToken;
             return response()->json([
                 'success' => true,
                 'token' => $token,
                 'user' => $user
             ]);
         } else {
             return response()->json([
                 'success' => false,
                 'message' => 'Invalid credentials'
             ], 401);
         }
     }
    //end users
     // groups
     public function logingroups(Request $request)
     {
             $validator = Validator::make($request->all(),[
                 'car_number' => 'required',
                 'password' => 'required',
             ]);
             if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }
             $credentials = $request->only('car_number', 'password');
     
             $group = Group::where('car_number', $request->car_number)->first();
     
             if ($group && $request->password === $group->password) {
                 $token = $group->createToken('group-token')->plainTextToken;
     
                 return response()->json([
                     'success' => true,
                     'token' => $token,
                     'group' => $group
                 ]);
             } else {
                 return response()->json([
                     'success' => false,
                     'message' => 'Invalid credentials'
                 ], 401);
             }
     }
     

     //end groups
    /**
     * Write code on Method
     *
     * @return response()
     */
//ADMIN
     public function showloginadmin()
     {
         return view('login');
     } 
    
    public function postLogin(Request $request)
{
    $request->validate([
        'phone_number' => 'required',
        'password' => 'required',
    ]);
    $credentials = $request->only('phone_number', 'password');
    if (Auth::attempt($credentials)) {
        // تحقق من دور المستخدم
        if (Auth::user()->role == 1) {
            return redirect()->intended('homeadmin')
                        ->withSuccess('You have Successfully loggedin');
        } else {        
            Auth::logout();
            return redirect("/")->withErrors('You do not have permission as an admin.');
        }
    }
    return redirect("/")->withErrors('Oppes! You have entered invalid credentials');
}

    /**
     * Write code on Method
     *
     * @return response()
     */

}
