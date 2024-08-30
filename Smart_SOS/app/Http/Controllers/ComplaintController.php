<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ComplaintController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        
        $complaints = Complaint::where('user_id', $user->id)->with('status')->get();

        return response()->json([
            'success' => true,
            'data' => $complaints,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'message' => 'required|string',
        ]);

        // إنشاء الشكوى
        $complaint = Complaint::create([
            'user_id' => Auth::id(),
            'message' => $request->message,
            'c_status_id' => 1, 
        ]);

        return response()->json([
            'success' => true,
            'data' => $complaint,
            'message' => 'تم تقديم الشكوى بنجاح'
        ], 201);
    }

    // تحديث الشكوى برد المدير
    public function respondToComplaint(Request $request, $id)
    {
        // التحقق من المدخلات
        $request->validate([
            'responcedir' => 'required|string',
        ]);

        // العثور على الشكوى المحددة
        $complaint = Complaint::find($id);

        // التحقق من وجود الشكوى
        if (!$complaint) {
            return response()->json([
                'success' => false,
                'message' => 'لم يتم العثور على الشكوى المطلوبة'
            ], 404);
        }

        // تحديث رد المدير على الشكوى
        $complaint->responcedir = $request->responcedir;
        $complaint->c_status_id = 2; // تغيير حالة الشكوى بعد الرد (مثلاً 2 تعني تمت معالجتها)
        $complaint->save();

        return response()->json([
            'success' => true,
            'data' => $complaint,
            'message' => 'تم تحديث الشكوى بنجاح مع رد المدير'
        ], 200);
    }
}
