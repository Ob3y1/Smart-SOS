<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

use Illuminate\Support\Facades\Validator;
use Auth;

class UserController extends Controller
{
    public function show()
    {
    // الحصول على المستخدم الحالي
    $user = Auth::user();

    // إرجاع المعلومات الشخصية
    return response()->json([
        'success' => true,
        'user' => $user
    ]);
}
    public function update(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(),[
            'name' => 'required|string|max:255',
            'phone_number' => 'required|unique:users,phone_number,' . $user->id,
            'password' => 'nullable|string',
            'date_of_birth' => 'nullable|date',
            'gender' => 'nullable|string|in:male,female',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $user->name = $request->name;
        $user->phone_number = $request->phone_number;
        $user->date_of_birth = $request->date_of_birth;
        $user->gender = $request->gender;

        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }

        $user->save();

        return response()->json(['message' => 'Profile updated successfully']);
    }
    public function logoutusers(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Logged out successfully'
        ]);
    }
}
