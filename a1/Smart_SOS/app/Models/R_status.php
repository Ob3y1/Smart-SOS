<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class R_status extends Model
{
    use HasFactory;
    protected $guarded=[];
    public function GroupRequest(){
        return $this->hasMany(GroupRequest::class);
     }

}
