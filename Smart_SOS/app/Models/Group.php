<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;


class Group extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'groups';
    protected $fillable =[
        'job_id',
        'car_number',
        'site_id',
        'group_status',
        'password',
        'created_at',
        'updated_at',
    ];
      public function GroupRequest(){
        return $this->hasMany(GroupRequest::class);
     }
     public function Job()
     {
         return $this->belongsTo(Job::class,'job_id');
     }
     public function Site()
     {
         return $this->belongsTo(Site::class,'site_id');
     }
     protected $hidden = [
        'password',
        'remember_token',
        
    ];
}
