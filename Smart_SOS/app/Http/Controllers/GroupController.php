<?php

namespace App\Http\Controllers;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use App\Models\Site;
use App\Models\User;
use App\Models\Job;
use App\Models\Otp;
use App\Models\Group;
use App\Models\EmergencyRequest;
use App\Models\GroupRequest;
use App\Http\Controllers\UserController;

class groupController extends Controller
{
    public function get_request_notification()
    {
        $user = Auth::user();
        if ($user->group_status == 1) {
            $userid = Auth::id();
            $grouprequests = GroupRequest::where('group_id', $userid)->where('request_status', 1)->get();
            if ($grouprequests->isNotEmpty()) {
                
                $requests = [];
                foreach ($grouprequests as $grouprequest) {
                    $emergencyrequest = EmergencyRequest::where('id', $grouprequest->emergency_request_id)->first();
                    if ($emergencyrequest) {
                        $requests[] = [
                            'id' => $grouprequest->id,
                            'phone_number' => $emergencyrequest->User->Otp->identifier,
                            'name' => $emergencyrequest->User->name,
                            'latitude' => $emergencyrequest->latitude,
                            'longitude' => $emergencyrequest->longitude,
                            'details' => $emergencyrequest->details,
                        ];
                    }
                }
                return response()->json([
                    'success' => true,
                    'requests' => $requests,
                    'user' => $user
                ]);
            } else {
                return response()->json([
                    'message' => 'لا يوجد طلبات حاليا',
                    'user' => $user
                ]);
            }
        } elseif ($user->group_status == 0) {
            return response()->json([
                'success' => false,
                'user' => $user,
                'message' => 'وضعك غير متاح الرجاء تبديل الوضع الى متاح'
            ],201);
        }
    }

       
    public function agree($id, UserController $userController)
    {
        // جلب الطلب المستهدف بناءً على معرفه
        $groupRequest = GroupRequest::where('id', $id)->first();
    
        // التحقق من وجود الطلب وأن حالته هي 1 (لم تتم معالجته بعد)
        if ($groupRequest && $groupRequest->request_status == 1) {
            // تحديث حالة الطلب إلى 2 (تم القبول)
            $groupRequest->request_status = 2;
            $groupRequest->save();
    
            // جلب المستخدم الحالي وتحديث حالته
            $user = Auth::user();
            $user->group_status = 0;
            $user->save();
    
            // جلب الطلبات الأخرى المسندة إلى نفس المستخدم
            $groupRequestsOther = GroupRequest::where('group_id', $user->id)->where('request_status', 1)->get();
    
            // توزيع الطلبات الأخرى على المجموعات المتاحة
            foreach ($groupRequestsOther as $groupRequestOther) {   
                $jobIdOther = $groupRequestOther->Group->job_id;
                $foundOtherGroup = false;
    
                // جلب الطلب الطارئ المرتبط وتحديد المواقع
                $emergencyRequestOther = EmergencyRequest::find($groupRequestOther->emergency_request_id);
                $distanceOther = $userController->locations1($emergencyRequestOther->latitude, $emergencyRequestOther->longitude);
                $dlengthOther = count($distanceOther);
    
                // البحث عن مجموعة أخرى متاحة
                for ($j = 0; $j < $dlengthOther; $j++) {
                    $groupOther = Group::where('job_id', $jobIdOther)
                        ->where('site_id', $distanceOther[$j]['point']['id'])
                        ->where('group_status', 1)
                        ->first();
    
                    if ($groupOther) {
                        // تعيين الطلب إلى المجموعة الجديدة وتحديث الحالة
                        $groupRequestOther->group_id = $groupOther->id;
                        $groupRequestOther->request_status = 1;
                        $groupRequestOther->save();
                        $foundOtherGroup = true;
                        break;
                    }
                }
    
                // إذا لم يتم العثور على مجموعة أخرى، إعادة تعيين الطلب للمستخدم الحالي
                if (!$foundOtherGroup) {
                    $groupRequestOther->group_id = Auth::id();
                    $groupRequestOther->request_status = 1;
                    $groupRequestOther->save();
                }
            }
    
            // إرجاع استجابة JSON لنجاح العملية
            return response()->json([
                'success' => true,
            ], 200); 
    
        } else {
            // إرجاع استجابة JSON لعدم العثور على الطلب
            return response()->json([
                'success' => false,
                'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
            ], 404);
        }
    }
    

    public function refuse($id, UserController $userController)
    {    
        $groupRequest = GroupRequest::where('id', $id)->where('request_status', 1)->first();
        if ($groupRequest){
            $userJob = $groupRequest->Group->job_id;
            $emergencyRequest = EmergencyRequest::where('id', $groupRequest->emergency_request_id)->first();
            $userLatitude = $emergencyRequest->latitude;
            $userLongitude = $emergencyRequest->longitude;
            $distance = $userController->locations1($userLatitude, $userLongitude);
            $dlength = count($distance);
            $foundGroup = false;
    
            for ($j = 0; $j < $dlength; $j++) { 
                $group = Group::where('job_id', $userJob)
                    ->where('site_id', $distance[$j]['point']['id'])
                    ->where('group_status', 1)
                    ->where('id', '!=', Auth::id())
                    ->first();
                if ($group) {
                    $groupRequest->group_id = $group->id;
                    $groupRequest->save();
                    $foundGroup = true;
                    break;
                }
            }
    
            if (!$foundGroup) {
                $groupRequest->group_id = Auth::id();
                $groupRequest->request_status = 2;
                $groupRequest->save();
                $user = Auth::user();
                $user->group_status = 0;
                $user->save();
    
                $groupRequestsOther = GroupRequest::where('group_id', $user->id)->where('request_status', 1)->get();
                foreach ($groupRequestsOther as $groupRequestOther){   
                    $jobIdOther = $groupRequestOther->Group->job_id;
                    $foundOtherGroup = false;
                    $emergencyRequestOther = EmergencyRequest::find($groupRequestOther->emergency_request_id);
                    $distanceOther = $userController->locations1($emergencyRequestOther->latitude, $emergencyRequestOther->longitude);
                    $dlengthOther = count($distanceOther);
                    for ($j = 0; $j < $dlengthOther; $j++){
                        $groupOther = Group::where('job_id', $jobIdOther)
                            ->where('site_id', $distanceOther[$j]['point']['id'])
                            ->where('group_status', 1)
                            ->first();
                        if ($groupOther){
                            $groupRequestOther->group_id = $groupOther->id;
                            $groupRequestOther->request_status = 1;
                            $groupRequestOther->save();
                            $foundOtherGroup = true;
                            break;
                        }
                    }
                    if (!$foundOtherGroup){
                        $groupRequestOther->group_id = Auth::id();
                        $groupRequestOther->request_status = 1;
                        $groupRequestOther->save();
                    }
                }
                return response()->json([
                    'success' => true,
                    'message' => 'لا يوجد سواك..قم بالمهمة'
                ], 200);
            } else {
                return response()->json([
                    'success' => true,
                ], 200);    
            }
        } else {
            return response()->json([
                'success' => false,
                'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
            ], 404);
        } 
    }
    
    public function change_status()
    {
        $user = Auth::user();
    
        if ($user->group_status == 1) {
            $user->group_status = 0;
        } else {
            $groupRequest = GroupRequest::where('group_id', $user->id)
                                        ->where('request_status', 2)
                                        ->first();
            if ($groupRequest) {
                return response()->json([
                    'message' => 'لا يمكن تغيير الوضع'
                ], 201);  
            } else {
                $user->group_status = 1; 
            }
        }
        $user->save();
    
        return response()->json([
            'message' => 'تم تغيير الوضع',
            'status' => $user->group_status
        ], 200); 
    }
    
    // public function home()
    // {
    //     $user = Auth::user();
    //     return response()->json([
    //         'user' => $user,
    //     ]); 
    // } 
    public function logout(Request $request)
     {
        $request->user()->currentAccessToken()->delete();
         return response()->json([
             'message' => 'Logged out successfully'
         ]);
     }
     public function show_info($id)
     {
        $grouprequest = GroupRequest::where('id',$id)->first();
        if($grouprequest->request_status==2){

            if ($grouprequest) {
                $emergencyrequest=EmergencyRequest::find($grouprequest->emergency_request_id);
                if ($emergencyrequest){
                    $birthdate = $emergencyrequest->User->date_of_birth;
                    $age = Carbon::parse($birthdate)->age;
                    return response()->json([
                                'id' => $grouprequest->id,
                                'phone_number' => $emergencyrequest->User->Otp->identifier,
                                'name' => $emergencyrequest->User->name,
                                'gender' => $emergencyrequest->User->gender,    
                                'age' => $age,
                                'latitude' => $emergencyrequest->latitude,
                                'longitude' => $emergencyrequest->longitude,
                                'details' => $emergencyrequest->details,
                            ]); 
                }else{
                    return response()->json([
                        'success' => false,
                        'message' => ' لم يتم العثور على الطلب أو البيانات المطلوبة'
                    ], 404);
                }
            }else {
                return response()->json([
                    'success' => false,
                    'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
                ], 404);
            }  
        }else
        return response()->json([
            'success' => false,
            'message' => '  الطلب منتهي اصلا  id خطأ'
        ], 404);
     }
    public function support($id , UserController $userController)
    {
        $grouprequest = GroupRequest::where('id', $id)->first();
        if($grouprequest->request_status==2){
            $emergencyRequest=EmergencyRequest::find($grouprequest->emergency_request_id);
            if ($emergencyRequest) {
                $jid = $grouprequest->Group->job_id;
                $eid = $grouprequest->emergency_request_id;
                $tm = 0;
                $distance = $userController->locations1($emergencyRequest->latitude, $emergencyRequest->longitude);
                $dlength = count($distance);
                for ($j = 0; $j < $dlength; $j++){
                    $group = Group::where('job_id', $jid)
                                ->where('site_id', $distance[$j]['point']['id'])
                                ->where('group_status', 1)
                                ->first();
                    if ($group) {
                        $groupRequest = new GroupRequest();
                        $groupRequest->group_id = $group->id;
                        $groupRequest->request_status = 1;
                        $groupRequest->emergency_request_id = $eid;
                        $groupRequest->save();
                        $tm = 1;
                        break;
                    }
                }
                if ($tm == 1) {
                    return response()->json([
                        'message' => 'Request processed successfully'
                    ], 200);
                } else {
                    return response()->json(['message' => 'هناك مشكلة في طلب الدعم '], 201);
                }
            } else {
                return response()->json(['message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'], 404);
            }
        }else
        return response()->json([
            'success' => false,
            'message' => '  الطلب منتهي اصلا  id خطأ'
        ], 404);

    }

    public function finish(Request $request)
    {
        $userid = Auth::id();
        $grouprequest = GroupRequest::where('id',$request->id)->first();
        if($grouprequest->request_status==2){
        $false=$request->false;
        if( $grouprequest){
            if($false==1)
            {
                $grouprequest->request_status=3;
                $grouprequest->false_notification=1;
                $grouprequest->save();

                return response()->json([
                    'success' => true,
                    'message' => 'شكرا لاتمام المهمة'
                ], 200);    
            }else{
                $grouprequest->request_status=3;
                $grouprequest->save();
                return response()->json([
                    'success' => true,
                    'message' => 'شكرا لاتمام المهمة'
                ], 200);         
            }
        }else
        return response()->json([
            'success' => false,
            'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
        ], 404);
    }else
    return response()->json([
        'success' => false,
        'message' => '  الطلب منتهي اصلا  id خطأ'
    ], 404);
}
}
