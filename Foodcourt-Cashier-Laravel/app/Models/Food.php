<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Food extends Model
{
    use HasFactory;

    protected $fillable = [
        'tenant_id','name', 'description', 'price', 'img_path'
    ];

    public function transaction_food(){
        return $this->hasMany(Transaction_Food::class);
    }

    public function tenant(){
        return $this->belongsTo(Tenant::class);
    }
}
