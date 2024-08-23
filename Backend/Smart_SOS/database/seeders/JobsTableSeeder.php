<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JobsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('jobs')->insert([
            ['title' => 'إطفاء'],
            ['title' => 'شرطة'],
            ['title' => 'غوص'],
            ['title' => 'إسعاف'],
        ]);
    }
}
