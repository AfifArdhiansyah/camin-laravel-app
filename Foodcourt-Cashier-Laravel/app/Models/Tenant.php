<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tenant extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'username', 'password'
    ];

    public function food(){
        return $this->hasMany(Food::class);
    }
}
