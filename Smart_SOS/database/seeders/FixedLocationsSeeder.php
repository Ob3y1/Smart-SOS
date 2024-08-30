<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Site;


class FixedLocationsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $locations = [
            ['name' => 'المدينة القديمة', 'latitude' => '33.50558773140988' , 'longitude' => '36.312259951059644'],
            ['name' => 'برزة', 'latitude' =>'33.54547629352869' , 'longitude' =>'36.30653512644752'],
            ['name' => 'دمر', 'latitude' => '33.52568238997799' , 'longitude' =>'36.22484147937865'],
            ['name' => 'جوبر', 'latitude' =>'33.521387062189575', 'longitude' => '36.33005304592363'],
            ['name' => 'قنوات', 'latitude' => '33.511070592365165', 'longitude' => '36.2974954255101'],
            ['name' => 'كفرسوسة', 'latitude' => '33.500471258881355', 'longitude' => '36.27870090117518'],
            ['name' => 'مزة', 'latitude' => '33.49735228744302', 'longitude' =>  '36.245210073020004'],
            ['name' => 'ميدان', 'latitude' => '33.48321860684221', 'longitude' =>'36.292256951732426'],
            ['name' => 'مهاجرين', 'latitude' =>'33.52325379473933', 'longitude' =>  '36.27697066506552'],
            ['name' => 'قابون', 'latitude' => '33.53299253494316', 'longitude' =>'36.32402288497481'], 
            ['name' => 'ركن الدين', 'latitude' => '33.52682006543696', 'longitude' => '36.28982359861126'],
            ['name' => 'عرنوس', 'latitude' => '33.521417337750464', 'longitude' => '36.29283962199972'],
            ['name' => 'شاغور', 'latitude' => '33.50584873725756', 'longitude' => '36.312128518608574'],
            ['name' => 'يرموك', 'latitude' => '33.47026437535047', 'longitude' => '36.29963603877028'],
        ];
        foreach ($locations as $location) {
            Site::create($location);
        }
    }
}
