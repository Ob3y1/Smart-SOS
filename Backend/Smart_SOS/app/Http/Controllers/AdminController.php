<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Group;
use App\Models\Job;
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
        return view('AddGroups');
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
        $group->site = $request->input('site');
        $group->password = $request->input('password');
        $group->save();
        return redirect('ShowGroups');
        }
    public function index()
    {
        return view('ShowGroups');
    }
    public function index1($job)
    { 
        $groups = Group::where('job_id',$job)->paginate(10);
        return view('ShowGroups1', compact('groups','job'));
    }  
    public function simple(Request $request)
    {
        $job = $request->job;
       
        if ($request->input('searchselect')) {   
            $groups = Group::where('job_id', $job)
                           ->where('site', 'LIKE', "%" . $request->searchselect . "%")
                           ->paginate(100);
        } else {
            $groups = Group::where('job_id', $job)
                           ->paginate(10);
        }
        return view('ShowGroups1', compact('groups', 'job'));
    }
    
    public function details1($id)
    { 
        $group = Group::findOrFail($id); // استرجاع السجل أو ترمي استثناءً إذا لم يتم العثور عليه
        return view('showdetails', compact('group'));
    } 
    public function updateGroup1($id)
    {
        $group = Group::findOrFail($id);
        return view('edit', compact('group'));
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
        $group->site = $request->input('site');
        $group->password = $request->input('password');
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
        $fullName=$user->name;
        $splitName = explode(' ', $fullName, 2);
        $firstName = $splitName[0];
        $lastName = isset($splitName[1]) ? $splitName[1] : '';

        return view('profile', compact('user' , 'firstName', 'lastName'));
    }
    public function profile1(Request $request)
    {     
        $id=Auth::user()->id;
        $rules = [
            'phone_number' => 'unique:users,phone_number,' . $id,
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
        $user->phone_number = $request->phone_number;
        $user->date_of_birth = $request->date_of_birth;
        $user->gender = $request->gender;
    
        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }
        $user->update();
           return redirect('homeadmin')->with('success', 'تم التعديل بنجاح');
    }
}
