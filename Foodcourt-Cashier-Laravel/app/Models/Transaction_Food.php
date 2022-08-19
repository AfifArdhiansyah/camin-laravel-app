<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction_Food extends Model
{
    use HasFactory;

    protected $fillable = [
        'transaction_id', 'food_id', 'quantity', 'total'
    ];
    
    public function food(){
        return $this->belongsTo(Food::class);
    }

    public function transaction(){
        return $this->belongsTo(Transaction::class);
    }
}
