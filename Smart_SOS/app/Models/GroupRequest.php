<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupRequest extends Model
{
    use HasFactory;
    protected $fillable = [
        'group_id',
        'request_id',
        'request_status',
        'false_notification	',
        'user_note',
        'emergency_request_id'

    ];    
    public function EmergencyRequest()
    {
        return $this->belongsTo(EmergencyRequest::class,'emergency_request_id');
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
