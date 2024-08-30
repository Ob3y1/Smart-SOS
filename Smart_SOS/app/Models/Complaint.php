<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Complaint extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'message', 'responcedir', 'c_status_id'];

    public function status()
    {
        return $this->belongsTo(c_statuses::class, 'c_status_id');
    }
    public function User()
    {
        return $this->belongsTo(User::class,'user_id');
    }
}
