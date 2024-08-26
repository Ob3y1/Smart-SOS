<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\Site;
use App\Models\User;
use App\Models\Job;

use App\Models\Group;
use App\Models\EmergencyRequest;
use App\Models\GroupRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;;
use GuzzleHttp\Client;
use Session;


class UserController extends Controller
{
    public function show()
   { $user = Auth::user();
    $phone_number= $user->Otp->identifier;
    $localNumber = '0' . substr($phone_number, 4);

        return response()->json([
            'success' => true,
            'user' => $user,
            'phone_number'=>$localNumber
        ]);}
    public function update(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(),[
            'name' => 'required|string|max:255',
            'password' => 'nullable|string',
            'date_of_birth' => 'nullable|date',
            'gender' => 'nullable|string|in:male,female',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $user->name = $request->name;
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
    // public function locations(Request $request)
    // {
    //     $latitude = $request->input('latitude');
    // $longitude = $request->input('longitude');

    // $fixedLocations = Site::all();

    // $distances = [];
    // $distancesmap = [];
    // foreach ($fixedLocations as $location) {
    //     $latitude1 = floatval( $location->latitude);
    //     $longitude1 = floatval($location->longitude);

    //     $distance = $this->haversineGreatCircleDistance($latitude, $longitude,$latitude1, $longitude1);
    //     $distances[] = ['name' => $location->name, 'distance' => $distance];
    // }

    // usort($distances, function ($a, $b) {
    //     return $a['distance'] <=> $b['distance'];
    // });
    // return response()->json($distances);

    // // return response()->json(array_slice($distances, 0, 2));

    // }
    
    // public function haversineGreatCircleDistance($latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371)
    // {
    //     $latFrom = deg2rad($latitudeFrom);
    //     $lonFrom = deg2rad($longitudeFrom);
    //     $latTo = deg2rad($latitudeTo);
    //     $lonTo = deg2rad($longitudeTo);

    //     $latDelta = $latTo - $latFrom;
    //     $lonDelta = $lonTo - $lonFrom;

    //     $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
    //         cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
    //     return $angle * $earthRadius;
    // }
public function l(){
    return response()->json(Auth::id());
}


    public function homeuser(Request $request)
    {
        $userLatitude = $request->input('latitude');
        $userLongitude = $request->input('longitude');
        $distance = $this->locations1($userLatitude, $userLongitude);

        $type=$request->input('type');
        $details=$request->input('details');
        $array = explode('.', $type); 
        $numericArray = array_map('intval', $array); 
        $emergencyRequest = new EmergencyRequest();
        $emergencyRequest->user_id = Auth::id();
        $emergencyRequest->latitude =$userLatitude;
        $emergencyRequest->longitude = $userLongitude;
        $emergencyRequest->details = $details ?? null;
        $emergencyRequest->save();
        $length = count($numericArray);
        $dlength = count($distance);
        $m=$length ;
        for ($i=0; $i <$length; $i++) { 
            for ($j=0; $j <$dlength; $j++) { 
                $group = Group::where('job_id', $numericArray[$i])->where('site_id', $distance[$j]['point']['id'])->where('group_status', 1)->first();
                if($group){
                    $groupRequest = new GroupRequest();
                    $groupRequest->group_id = $group->id;
                    $groupRequest->request_status = 1;
                    $groupRequest->emergency_request_id = $emergencyRequest->id;
                    $groupRequest->save();
                    unset($numericArray[$i]);
                    break;
                }
            }
        } 
        $numericArray = array_values($numericArray);

        $length = count($numericArray);
        if ($length) {
            $type=[];
            for ($i=0; $i <$length; $i++) { 
                $type[]= Job::find($numericArray[$i])->title;
            } 
            $typeString = implode(', ', $type);
            if ($length!=$m) {
                return response()->json([
                    'message1' => 'Request processed successfully',
                    'request' =>$emergencyRequest->id,
                    'message' => 'هناك مشكلة في إخطار زمرة ال' . $typeString,
                ]);
            }
            return response()->json(['message' => 'هناك مشكلة في إخطار زمرة ال' . $typeString,], 400);
        }else {
            return response()->json([
                'message' => 'Request processed successfully',
                'request' =>$emergencyRequest->id,
            ], 200);
        }
    }
    public function locations1($userLatitude,$userLongitude)
    {
       
        $client = new Client();
        $apiKey = 'AIzaSyDF2aMlopbsFK4EfbRCHsKnaScKGPvPI9k';
        $sites = Site::all();
        $distances = [];
    
        foreach ($sites as $point) {
            $response = $client->get("https://maps.googleapis.com/maps/api/distancematrix/json", [
                'query' => [
                    'origins' => "$userLatitude,$userLongitude",
                    'destinations' => "$point->latitude,$point->longitude",
                    'key' => $apiKey,
                    'mode' => 'driving'
                ]
            ]);
    
            $data = json_decode($response->getBody(), true);
            $distance = $data['rows'][0]['elements'][0]['distance']['value'];
            $duration = $data['rows'][0]['elements'][0]['duration']['value'];
            $distancetext = $data['rows'][0]['elements'][0]['distance']['text'];
            $durationtext = $data['rows'][0]['elements'][0]['duration']['text'];
            $distances[] = [
                'point' => $point,
                'distance' => $distance,
                'duration' => $duration,
                'distancetext' => $distancetext,
                'durationtext' => $durationtext,                
            ];
        }
    
        usort($distances, function ($a, $b) {
            return $a['distance'] - $b['distance'];
        });
    
        return $distances;
    }
    public function getStatus($id)
    {
        $groupRequest = GroupRequest::findOrFail($id);

        return response()->json(['request_status' => $groupRequest->request_status], 200);
    }
    public function getrequests($id)
    {   
        $emergencyRequest = EmergencyRequest::find($id);        
        if( $emergencyRequest){
            foreach ($emergencyRequest->GroupRequest as $value) {
                if ($value->request_status != 4){
                    $request[] = [
                        'id' => $value->id,
                        'group_id' => $value->group_id,
                        'emergency_request_id' => $value->emergency_request_id,
                        'car_number' => $value->Group->car_number,
                        'job'=>$value->Group->Job->title,
                        'site'=>$value->Group->Site->name,  
                        'request_status' => $value->request_status,
                    ];  
                }
            }
             return response()->json([
                'success' => true,
                'requests' => $request
            ],200); 
        }else
        return response()->json([
            'success' => false,
        ],400); 
    }
    public function sendnote(Request $request)
    {
        $id=$request->id;
        $groupRequest = GroupRequest::find($id);
        if ($groupRequest) {
            $groupRequest->user_note = $request->note;
            $groupRequest->request_status=4;
            $groupRequest->save();
            return response()->json(['message' => 'تم تسجيل ملاحظتك'], 200);
        } else {
            return response()->json(['message' => 'لم يتم العثور على الطلب'], 404);
        }
    }

}

