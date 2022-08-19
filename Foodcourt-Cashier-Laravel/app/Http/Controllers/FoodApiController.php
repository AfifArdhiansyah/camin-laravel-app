<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Food;

class FoodApiController extends Controller
{
    public function findFood($tenant_id){
        $find = Food::where('tenant_id', $tenant_id)->get();
        if($find)
            return response()->json(['message'=>'Success', 'data'=> $find]);
        else
            return response()->json(['message'=>'Data Not Found']);
    }

    public function allFood(){
        $find = Food::all();
        if($find)
            return response()->json(['message'=>'Success', 'data'=> $find]);
        else
            return response()->json(['message'=>'Data Not Found']);
    }

    public function createFood(Request $request){
        $this->validate($request, [
            'tenant_id' => 'required',
            'name' => 'required|string|max:155',            
            'description' => 'required',
            'price' => 'required',
            'img_path' => 'image|file|max:1024'
        ]);

        $food = Food::create([
            'tenant_id' => $request->tenant_id,
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'img_path' => $request->file('img_path')->store('post-image'),
        ]);

        if ($food) {            
            return response()->json(['message'=>'Success', 'data'=>$food]);
        } else {
            return response()->json(['message'=>'Store Fail']);
        }
    }

    public function editFood($id, Request $request){      
        $food = Food::findOrFail($id);

        $this->validate($request, [
            'tenant_id' => 'required',
            'name' => 'required|string|max:155',            
            'description' => 'required',
            'price' => 'required',
            'img_path' => 'image|file|max:1024'
        ]);

        $food->update([
            'tenant_id' => $request->tenant_id,
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'img_path' => $request->file('img_path')->store('post-image'),
        ]);

        if ($food) {            
            return response()->json(['message'=>'Success', 'data'=>$food]);
        } else {
            return response()->json(['message'=>'Store Fail']);
        }
    }
}
