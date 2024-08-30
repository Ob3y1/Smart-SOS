<?php
namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Http\Request;
use Ichtrojan\Otp\Otp;
use Twilio\Rest\Client;
use App\Models\Otp as OtpModel;
use Hash;
use Illuminate\Support\Facades\Validator;

class OtpController extends Controller
{
    public function SendOtp(Request $request)
    {    
        $phoneNumber = $request->input('phone_number');
        if (substr($phoneNumber, 0, 1) === '0') {
            $formattedNumber = '+963' . substr($phoneNumber, 1);
        } else {
            $formattedNumber = $phoneNumber;
        }
        $request->merge(['phone_number' => $formattedNumber]);

        $validator = Validator::make($request->all(), [
            'phone_number' => 'required|unique:otps,identifier|max:13',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $otp = new Otp;
        $otpDetails = $otp->generate($request->input('phone_number'), 'numeric', 4, 10);
        $client = new Client(env('TWILIO_SID'), env('TWILIO_AUTH_TOKEN'));
        $message = $client->messages->create(
            $request->input('phone_number'),
            [
                'from' => env('TWILIO_PHONE_NUMBER'),
                'body' => "Your OTP code is: $otpDetails->token"
            ]
        );
        
        if($message) 
            return response()->json(['message' => 'Please enter the code you received.',  ]);
        else
            return response()->json(['message' => 'There is a problem sending the code.. Try again']);
    }


    public function verifyOtpSignUp(Request $request)
    {    
        $phoneNumber = $request->input('phone_number');
        if (substr($phoneNumber, 0, 1) === '0') {
            $formattedNumber = '+963' . substr($phoneNumber, 1);
        } else {
            $formattedNumber = $phoneNumber;
        }
        $request->merge(['phone_number' => $formattedNumber]);
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'date_of_birth' => 'required',
            'gender' => 'required|string|in:male,female',
            'password' => 'required|string',
            'otp' => 'required|min:4',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $identifier = $request->input('phone_number'); 
        $token =$request->input('otp');
        $otpRecord = OtpModel::where('identifier', $identifier)
        ->where('token', $token)
        ->where('valid', true)
        ->first();
        if ($otpRecord) {
            $createdTime = $otpRecord->created_at;
            $currentTime = now();
            $validityPeriod = $otpRecord->validity;   
            $timeDifference = $currentTime->diffInMinutes($createdTime);

            if ($timeDifference <= $validityPeriod) {
               
                $user = User::create([
                    'name' => $request->name,
                    'otp_id' => $otpRecord->id,
                    'date_of_birth' => $request->date_of_birth,
                    'gender' => $request->gender,
                    'password' => Hash::make($request->password),
                    'role'=> 0
                ]);
                $otpRecord->update(['valid' => false]); 
                return response()->json([
                    'success' => true,
                    'message' => 'Account created successfully.OTP verified successfully.Please login.',
                ], 201);
            } else {
                $otpRecord->update(['valid' => false]); 
                return response()->json(['message' => 'OTP has expired.. go back and try again'], 400);
            }
        } else {
            return response()->json(['message' => 'OTP code or phone number not found'], 400);
        }
    }
}