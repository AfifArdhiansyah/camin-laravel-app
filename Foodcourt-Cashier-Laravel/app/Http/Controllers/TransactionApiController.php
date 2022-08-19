<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Transaction;
use App\Models\Transaction_Food;
use App\Models\Food;

class TransactionApiController extends Controller
{
    public function createTransaction(Request $request){
        $this->validate($request, [
            'name' => 'required|string|max:155',
            'note' => 'nullable'
        ]);

        $transaction = Transaction::create([
            'name' => $request->name,
            'note' => $request->note,
            'total' => 0,
            'paid' => false,
            'served' => false
        ]);

        if ($transaction) {            
            return response()->json(['message'=>'Success', 'data'=>$transaction]);
        } else {
            return response()->json(['message'=>'Store Fail']);
        }
    }

    public function updateTransaction($id){
        $transaction = Transaction::findOrFail($id);

        $total = Transaction_Food::where('transaction_id', $id)->sum('total');

        $transaction->update([
            'total' => $total,
        ]);

        if ($transaction) {            
            return response()->json(['message'=>'Success', 'data'=>$transaction]);
        } else {
            return response()->json(['message'=>'Update Fail']);
        }
    }

    public function storeTransaction(Request $request){
        $this->validate($request, [
            'name' => 'required|string|max:155',
            'note' => 'nullable',
            'order' => 'required',
            'paid' => 'required'
        ]);

        $transactionCreate = Transaction::create([
            'name' => $request->name,
            'note' => $request->note,
            'total' => 0,
            'paid' => $request->paid,
            'served' => false
        ]);

        if ($transactionCreate) {            
            $trans_id = $transactionCreate->id;

            foreach ($request->order as $key => $value) {
                $price = Food::findOrFail($key);
                $price = $price->price;
                $tras_food = Transaction_Food::create([
                    'transaction_id' => $trans_id,
                    'food_id' => $key,
                    'quantity' => $value,
                    'total' => $price*$value
                ]);
                if(!$tras_food){
                    return response()->json(['message'=>'Store Fail In Data-' + $key]);
                }            
            }

            $transactionUpdate = Transaction::findOrFail($trans_id);
            $total = Transaction_Food::where('transaction_id', $trans_id)->sum('total');

            $transactionUpdate->update([
                'total' => $total,
            ]);

            if ($transactionUpdate) {            
                return response()->json(['message'=>'Success', 'data'=>$transactionUpdate]);
            } else {
                return response()->json(['message'=>'Set Total Fail']);
            }

        }else {
            return response()->json(['message'=>'Store Fail']);
        }
    }

    public function setServed($id)
    {
        $find = Transaction::findOrFail($id);

        $find->update([
            'served' => true
        ]);

        if($find){
            return response()->json(['message'=>'Set Served Success', 'data'=>$find]);
        }
        else{
            return response()->json(['message'=>'Set Served Fail']);
        }
    }

    public function getHistory($id)
    {
        $find = Transaction_Food::where('transaction_id', $id)->with();

        if($find){
            return response()->json(['message'=>'Set Served Success', 'data'=>$find]);
        }
        else{
            return response()->json(['message'=>'Set Served Fail']);
        }
    }
}
