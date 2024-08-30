<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Hash;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        
        DB::table('otps')->insert([
            'identifier' => "+963962256897",
            'token'=>"0000",
            'validity'=>0,
            'valid'=>1
        ]);
        DB::table('users')->insert([
            'name' =>"أبي موسى " ,
            'otp_id' => 1,
            'date_of_birth' => "2002-10-16",
            'gender' => "male",
            'password' => Hash::make("111q"),
            'role'=> 1
        ]);  
        DB::table('r_statuses')->insert([
            ['title' => 'جارٍ الإرسال'],
            ['title' => 'تم استلام طلبك'],
            ['title' => 'تم الانتهاء']  
        ]);
        DB::table('groups')->insert([
            [
                'job_id' => 1, 
                'car_number' => '111111',
                'site_id' => 1, 
                'group_status' => 1, 
                'password' => Hash::make('111q')
            ],
            [ 
                'job_id' => 2, 
                'car_number' => '222222',
                'site_id' => 1, 
                'group_status' => 1, 
                'password' => Hash::make('111q')
            ],
            [ 
                'job_id' => 3, 
                'car_number' => '333333',
                'site_id' => 1, 
                'group_status' => 1, 
                'password' => Hash::make('111q')
            ],
            [ 
                'job_id' => 4  , 
                'car_number' => '111112',
                'site_id' => 1, 
                'group_status' => 1, 
                'password' => Hash::make('111q')
            ],
            [ 
                'job_id' => 1  , 
                'car_number' => '111113',
                'site_id' => 1, 
                'group_status' => 1, 
                'password' => Hash::make('111q')
            ],
        ]);
        DB::table('c_statuses')->insert([
            ['name' => 'انتظار'],
            ['name' => 'طور المعالجة'],
            ['name' => 'تمت المعالجة']  
        ]);
      
    }
}
