<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupRequest extends Model
{
    use HasFactory;
    protected $guarded=[];
    public function EmergencyRequest()
    {
        return $this->belongsTo(EmergencyRequest::class,'request_id');
    }
    public function Group()
    {
        return $this->belongsTo(Group::class,'group_id');
    }
    public function R_status()
    {
        return $this->belongsTo(R_status::class,'request_status');
    }
}
