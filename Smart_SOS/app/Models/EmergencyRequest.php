<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmergencyRequest extends Model
{
    use HasFactory;
    protected $guarded=[];
    public function GroupRequest(){
        return $this->hasMany(GroupRequest::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class,'user_id');
    }
}
