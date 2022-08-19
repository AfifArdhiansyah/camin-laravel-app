<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'note', 'total', 'paid', 'served'
    ];

    public function transaction_food(){
        return $this->hasMany(Transaction_Food::class);
    }

    // public function transaction_food(){
    //     return $this->belongsTo(Transaction_Food::class);
    // }
}
