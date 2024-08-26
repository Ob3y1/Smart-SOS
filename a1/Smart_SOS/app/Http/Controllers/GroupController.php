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
        $userid = Auth::id();
        $grouprequest = GroupRequest::where('group_id', $userid)->where('request_status', 1)->first();   
        if ($grouprequest) {
            $emergencyrequest=EmergencyRequest::where('id', $grouprequest->emergency_request_id )->first();
            if ($emergencyrequest){
                return response()->json([
                    'id' => $grouprequest->id,
                    'phone_number' => $emergencyrequest->User->Otp->identifier,
                    'name' => $emergencyrequest->User->name,
                    'latitude' => $emergencyrequest->latitude,
                    'longitude' => $emergencyrequest->longitude,
                    'details' => $emergencyrequest->details,
                    'user'=>$user
                ]);
            }else{
                return response()->json([
                    'success' => false,
                    'user'=>$user,
                    'message' => ' لم يتم العثور على الطلب أو البيانات المطلوبة'
                ], 404);
            }
        }else {
            return response()->json([
                'message' => 'لا يوجد طلبات حاليا',
                'user'=>$user
            ]);
        }
    }
    
    public function agree($id)
    {
        $grouprequest = GroupRequest::where('id', $id)->first();
        if ($grouprequest) {
            $grouprequest->request_status=2;
            $grouprequest->save();
            $user = Auth::user();
            $user->group_status=0;
            $user->save();
            return response()->json([
                'success' => true,
            ],200); 
        }else {
            return response()->json([
                'success' => false,
                'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
            ], 404);
        }
    }
    public function j($id){
        $grouprequest = GroupRequest::where('id', $id)->where('request_status', 1)->first();
        $userjob=$grouprequest->Group->job_id;
        return response()->json($userjob);
    }
//     public function refuse($id, UserController $userController)
// {
//     $grouprequest = GroupRequest::with(['Group', 'EmergencyRequest.User.Otp'])
//         ->where('id', $id)
//         ->where('request_status', 1)
//         ->first();

//     if ($grouprequest) {
//         $userjob = $grouprequest->Group->job_id;
//         $emergencyrequest = $grouprequest->EmergencyRequest;

//         if ($emergencyrequest) {
//             $userLatitude = $emergencyrequest->latitude;
//             $userLongitude = $emergencyrequest->longitude;
//             $distance = $userController->locations1($userLatitude, $userLongitude);
//             $dlength = count($distance);

//             for ($j = 0; $j < $dlength; $j++) {
//                 $group = Group::where('job_id', $userjob)
//                     ->where('site_id', $distance[$j]['point']['id'])
//                     ->where('group_status', 1)
//                     ->first();

//                 if ($group) {
//                     $grouprequest->group_id = $group->id;
//                     $grouprequest->save();
//                     break;
//                 }
//             }

//             return response()->json([
//                 'success' => true,
//             ], 200);
//         }
//     }

//     return response()->json([
//         'success' => false,
//         'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
//     ], 404);
// }

public function refuse($id, UserController $userController)
    {    
        $grouprequest = GroupRequest::where('id', $id)->where('request_status', 1)->first();
        if ($grouprequest) {
            $userjob=$grouprequest->Group->job_id;
            $emergencyrequest=EmergencyRequest::where('id', $grouprequest->emergency_request_id )->first();
            $userLatitude = $emergencyrequest->latitude;
            $userLongitude = $emergencyrequest->longitude;
            $distance = $userController->locations1($userLatitude, $userLongitude);
            $dlength = count($distance);
                for ($j=0; $j <$dlength; $j++) { 
                    $group = Group::where('job_id',$userjob)->where('site_id', $distance[$j]['point']['id'])->where('group_status', 1)->where('id', '!=', Auth::id())->first();
                    if($group){
                        $grouprequest->group_id=$group->id;
                        $grouprequest->save();
                        break;
                    }else{
                    $grouprequest->group_id=Auth::id();
                    $grouprequest->request_status=2;
                    $grouprequest->save();
                    $user = Auth::user();
                    $user->group_status=0;
                    $user->save();
                    return response()->json([
                        'success' => true,
                        'message' => 'لا يوجد سواك..قم بالمهمة'
                    ],200); 
                } 
            }
                return response()->json([
                    'success' => true,
                ],200); 
        }else {
            return response()->json([
                'success' => false,
                'message' => 'لم يتم العثور على الطلب أو البيانات المطلوبة'
            ], 404);
        }
    }
    public function change_status()
    {
        $user = Auth::user();
        if( $user->group_status==0)
            $user->group_status=1;
        else
            $user->group_status=0;
        $user->save();
        return response()->json([
            'message' => 'تم تغيير الوضع',
            'status' =>$user->group_status
        ]);
    } 
    public function logout(Request $request)
     {
        $request->user()->currentAccessToken()->delete();
         return response()->json([
             'message' => 'Logged out successfully'
         ]);
     }
     public function show_info($id)
     {
        $grouprequest = GroupRequest::where('id',$request->id);
        if ($grouprequest) {
            $emergencyrequest=EmergencyRequest::where('id', $grouprequest->emergency_request_id )->first();
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
     }
    public function finish(Request $request)
    {
        $userid = Auth::id();
        $grouprequest = GroupRequest::where('id',$request->id);
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
    }
    public function home()
    {
        $user = Auth::user();
        return response()->json([
            'user' => $user,
        ]); 
    }
}

