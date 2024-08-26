<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Group;
use App\Models\Job;
use App\Models\Site;

use Auth;
use Hash;
use Session;
use Illuminate\Support\Facades\Validator;

class AdminController extends Controller
{
    public function __construct()
    {
        $this->middleware('admin');
    }
    public function homeadmin()
    {
        return view('dashboard');
    }
    public function false()
    {
        return view('False');
    } 
    public function requests()
    {
        return view('requests');
    } 
    public function AddGroups()
    {
        $jobs = Job::all();
        $sites = Site::all();
        return view('AddGroups', compact('sites','jobs'));
    }

    public function store(Request $request)
    {
        $rules = [
            'car_num' => 'unique:groups,car_number',
        ];

        // تنفيذ التحقق
        $validator = Validator::make($request->all(), $rules);

        // التحقق من وجود أخطاء
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $group = new Group ;
        $group->job_id = $request->input('job');
        $group->car_number = $request->input('car_num');
        $group->site_id = $request->input('site');
        $group->password = Hash::make($request->input('password'));
        $group->save();
        return redirect('ShowGroups');
    }
    public function index()
    {
        return view('ShowGroups');
    }
    public function index1($job)
    { 
        $sites = Site::all();
        $groups = Group::where('job_id',$job)->paginate(10);
        return view('ShowGroups1', compact('groups','job','sites'));
    }  
    public function simple(Request $request)
    {
        $job = $request->job;
        $sites = Site::all();
        if ($request->input('searchselect')) {   
            $groups = Group::where('job_id', $job)
                           ->where('site_id', 'LIKE', "%" . $request->searchselect . "%")
                           ->paginate(100);
        } else {
            $groups = Group::where('job_id', $job)
                           ->paginate(10);
        }
        return view('ShowGroups1', compact('groups','job','sites'));
    }
    
    public function details1($id)
    { 
        $group = Group::findOrFail($id); // استرجاع السجل أو ترمي استثناءً إذا لم يتم العثور عليه
        return view('showdetails', compact('group'));
    } 
    public function updateGroup1($id)
    {
        $jobs = Job::all();
        $sites = Site::all();
        $group = Group::findOrFail($id);
        return view('edit', compact('group','jobs','sites'));
    }
    public function updateGroup2(Request $request, $id)
    { 
        $rules = [
            'car_num' => 'unique:groups,car_number,' . $id,
        ];

        // تنفيذ التحقق
        $validator = Validator::make($request->all(), $rules);

        // التحقق من وجود أخطاء
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $job = $request->input('job');
        $group = Group::find($id);
        if ($group) {
        $group->job_id = $request->input('job');
        $group->car_number = $request->input('car_num');
        $group->site_id = $request->input('site');
        if ($request->filled('password')) {
            $group->password = Hash::make($request->password);
        }       
         $group->update();
           return redirect('ShowGroups1/'.$job)->with('success', 'تم التعديل بنجاح');
        } else { 
            return redirect('ShowGroups1/'.$job)->with('error', 'الزمرة  التي تحاول تعديلها غير موجودة');

         }
    }

    public function deleteGroup1(Request $request)
    {
        $groupId = $request->input('group_id');
        $group = Group::find($groupId);
        if ($group) {
            $group->delete();
            return redirect()->back()->with('success', 'تم الحذف بنجاح');
        } else {
            return redirect()->back()->with('error', 'الزمرة  التي تحاول حذفها غير موجودة');
        }
    }
    public function deleteGroup2(Request $request)
    {  $job = $request->input('job_id');
        $groupId = $request->input('group_id');
        $group = Group::find($groupId);
        if ($group) {
            $group->delete();
            return redirect('ShowGroups1/'.$job)->with('success', 'تم الحذف بنجاح');
        } else {
            return redirect('ShowGroups1/'.$job)->with('error', 'الزمرة  التي تحاول حذفها غير موجودة');
        }
    }
    public function logout() {
        Session::flush();
        Auth::logout();

  return Redirect('/')->withSuccess('You Have Logout');
       
    }
    public function profile()
    {
        $id=Auth::user()->id;
        $user = User::findOrFail($id);
        $phoneNumber=$user->Otp->identifier;
        $fullName=$user->name;
        $splitName = explode(' ', $fullName, 2);
        $firstName = $splitName[0];
        $lastName = isset($splitName[1]) ? $splitName[1] : '';
        $localNumber = '0' . substr($phoneNumber, 4);
        return view('profile', compact('user' , 'firstName', 'lastName','localNumber'));
    }
    public function profile1(Request $request)
    {     
        $id=Auth::user()->id;
        $phoneNumber = $request->input('phone_number');
        if (substr($phoneNumber, 0, 1) === '0') {
            $formattedNumber = '+963' . substr($phoneNumber, 1);
        } else {
            $formattedNumber = $phoneNumber;
        }
        $request->merge(['phone_number' => $formattedNumber]);
        $rules = [
            'phone_number' => 'unique:otps,identifier,' . $id,
        ];
        // تنفيذ التحقق
        $validator = Validator::make($request->all(), $rules);
        // التحقق من وجود أخطاء
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        
        $id=Auth::user()->id;
        $user = User::find($id);
        $fullName = $request->fname . ' ' . $request->lname;
        $user->name =$fullName;
        $otp = $user->Otp;
        $otp->identifier = $request->input('phone_number');
        $otp->save(); 
        $user->date_of_birth = $request->date_of_birth;
        $user->gender = $request->gender;
    
        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }
        $user->update();
           return redirect('homeadmin')->with('success', 'تم التعديل بنجاح');
    }
}
