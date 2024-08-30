<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class c_statuses extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    // العلاقة مع النموذج Complaint
    public function complaints()
    {
        return $this->hasMany(Complaint::class, 'c_status_id');
    }
}
