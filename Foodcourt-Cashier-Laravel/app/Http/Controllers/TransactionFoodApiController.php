<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Transaction_Food;
use App\Models\Food;

class TransactionFoodApiController extends Controller
{
    public function createTransactionFood(Request $request){
        $this->validate($request, [
            'transaction_id' => 'required',
            'food_id' => 'required',
            'quantity' => 'required',
        ]);

        $price = Food::findOrFail($request->food_id);
        $price = $price->price;

        $transactionFood = Transaction_Food::create([
            'transaction_id' => $request->transaction_id,
            'food_id' => $request->food_id,
            'quantity' => $request->quantity,
            'total' => $request->quantity * $price
        ]);

        if($transactionFood){
            return response()->json(['message' => 'Success', 'data' => $transactionFood]);
        }
        else{
            return response()->json(['message' => 'Store Failed']);
        }
    }

    public function findTransactionFood($id){
        $find = Transaction_Food::where('transaction_id', $id)->get();

        if($find){
            return response()->json(['message' => 'Success', 'data' => $find]);
        }
        else{
            return response()->json(['message' => 'Data Not Found']);
        }
    }
}
