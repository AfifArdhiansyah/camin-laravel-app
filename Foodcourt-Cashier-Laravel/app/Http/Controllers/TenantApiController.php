<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tenant;
use App\Models\Transaction;

class TenantApiController extends Controller
{
    public function findTenant($username, $password)
    {
        $find = Tenant::where('username', $username)->first();
        if($find->password == $password)
            return response()->json(['message'=>'Success', 'data'=> $find]);
        else
            return response()->json(['message'=>'Wrong Password']);
    }

    public function allTenant()
    {
        $find = Tenant::all();
        if($find)
            return response()->json(['message'=>'Success', 'data'=> $find]);
        else
            return response()->json(['message'=>'Data Not Found']);
    }

    public function getQueue($id)
    {
        $find = Transaction::with('transaction_food')->where([
            ['paid', 1],
            ['served', 0]
        ])->get();
        $queue = [];
        $data = [];
        $order = [];

        foreach($find as $objectT){
            $check = false;
            $order = [];
            $transaction_foods = $objectT->transaction_food;            
            foreach($transaction_foods as $objectTf){
                if($objectTf->food->tenant_id == $id){
                    $objectTf->food['quantity'] = $objectTf->quantity;
                    array_push($order, $objectTf->food);
                    $data['order'] = $order;
                    $check = true;
                }             
            }
            if($check){
                $data['name'] = $objectT->name;
                $data['trans_id'] = $objectT->id;
                $data['note'] = $objectT->note;
                array_push($queue, $data); 
            }           
                       
        }
        
        if($queue)
            return response()->json(['message'=>'Success', 'data'=> $queue]);
        else
            return response()->json(['message'=>'Data Not Found']);
    }

    public function getHistory($id)
    {
        $find = Transaction::with('transaction_food')->where([
            ['paid', 1],
            ['served', 1]
        ])->latest()->get();
        $queue = [];
        $data = [];
        $order = [];

        foreach($find as $objectT){
            $check = false;
            $order = [];
            $data['total'] = 0;
            $transaction_foods = $objectT->transaction_food;            
            foreach($transaction_foods as $objectTf){
                if($objectTf->food->tenant_id == $id){
                    $data['total'] = $data['total'] + $objectTf->food->price * $objectTf->quantity;
                    $objectTf->food['quantity'] = $objectTf->quantity;
                    array_push($order, $objectTf->food);
                    $data['order'] = $order;
                    $check = true;
                }             
            }
            if($check){
                $data['name'] = $objectT->name;
                $data['date_time'] = $objectT->updated_at;
                array_push($queue, $data); 
            }           
                       
        }
        
        if($queue)
            return response()->json(['message'=>'Success', 'data'=> $queue]);
        else
            return response()->json(['message'=>'Data Not Found']);
    }
}
