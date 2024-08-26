<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Session;
use App\Models\User;
use App\Models\Group;
use App\Models\Otp;

use Hash;
use Illuminate\Support\Facades\Validator;


class AuthController extends Controller
{
   
    // users
     public function loginusers(Request $request)
     { 
        $phoneNumber = $request->input('phone_number');
        if (substr($phoneNumber, 0, 1) === '0') {
            $formattedNumber = '+963' . substr($phoneNumber, 1);
        } else {
            $formattedNumber = $phoneNumber;
        }
        $request->merge(['phone_number' => $formattedNumber]);

        $validator = Validator::make($request->all(),[
            'phone_number' => 'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $otp=OTP::where('identifier',$request->input('phone_number'))->first();
        $user = User::where('otp_id',$otp->id)->first();
     
        if ($user && Hash::check($request->password, $user->password)&&$user->role==0) {
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
            
             $group = Group::where('car_number', $request->car_number)->first();
     
             if ($group &&  Hash::check($request->password, $group->password) ) {
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
        $phoneNumber = $request->input('phone_number');
        if (substr($phoneNumber, 0, 1) === '0') {
            $formattedNumber = '+963' . substr($phoneNumber, 1);
        } else {
            $formattedNumber = $phoneNumber;
        }
        $request->merge(['phone_number' => $formattedNumber]);

        $request->validate([
            'phone_number' => 'required',
            'password' => 'required',
        ]);
        
     
        $otp = OTP::where('identifier', $request->input('phone_number'))->first();

        if ($otp) {
            $credentials = [
                'otp_id' => $otp->id,
                'password' => $request->input('password')
            ];

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
        } else {
            return redirect("/")->withErrors('OTP not found for the provided phone number');
        }

        return redirect("/")->withErrors('Oppes! You have entered invalid credentials');
    }

    /**
     * Write code on Method
     *
     * @return response()
     */

}
