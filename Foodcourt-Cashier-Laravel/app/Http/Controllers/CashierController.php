<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tenant;
use App\Models\Transaction;
use App\Models\Transaction_Food;
use Illuminate\Support\Facades\Http;

class CashierController extends Controller
{
    public function index(){
        $transactions = Transaction::orderBy('paid')->latest()->get();
        // $transactions = Transaction_Food::with('transaction', 'food')->latest()->get();
        return view('home', compact('transactions'));
    }

    public function history(){
        $transactions = Transaction::where([
            ['paid', '==', '1'],
            ['served', '==', '1']
        ])->get();
        return view('history', compact('transactions'));
    }

    public function tenant(){
        $tenants = Tenant::orderBy('id')->get();
        return view('tenant', compact('tenants'));
    }

    public function createTenant(){
        return view('post/post-tenant');
    }

    public function storeTenant(Request $request){
        $this->validate($request, [
            'name' => 'required|string|max:155',            
            'username' => 'required',
            'password' => 'required',
        ]);

        $tenant = Tenant::create([
            'name' => $request->name,
            'username' => $request->username,
            'password' => $request->password,
        ]);

        if ($tenant) {
            return redirect()
                ->route('home')
                ->with([
                    'success' => 'New item has been created successfully'
                ]);
        } else {
            return redirect()
                ->back()
                ->withInput()
                ->with([
                    'error' => 'Some problem occurred, please try again'
                ]);
        }
    }

    public function toEdit($id){
        $tenant = Tenant::findOrFail($id);
        return view('update/edit-tenant', compact('tenant'));
    }

    public function updateTenant(Request $request, $id){

        $tenant = Tenant::findOrFail($id);

        $this->validate($request, [
            'name' => 'required|string|max:155',            
            'username' => 'required',
            'password' => 'required',
        ]);

        $tenant->update([
            'name' => $request->name,
            'username' => $request->username,
            'password' => $request->password,
        ]);

        if ($tenant) {
            return redirect()
                ->route('home')
                ->with([
                    'success' => 'New item has been created successfully'
                ]);
        } else {
            return redirect()
                ->back()
                ->withInput()
                ->with([
                    'error' => 'Some problem occurred, please try again'
                ]);
        }
    }

    public function destroyTenant($id)
    {
        $tenant = Tenant::findOrFail($id);
        $tenant->delete();

        if ($tenant) {
            return redirect()
                ->route('home')
                ->with([
                    'success' => 'Post has been deleted successfully'
                ]);
        } else {
            return redirect()
                ->route('home')
                ->with([
                    'error' => 'Some problem has occurred, please try again'
                ]);
        }
    }

    public function setPaid($id)
    {
        $transaction = Transaction::findOrFail($id);
        $transaction->update([
            'paid' => true
        ]);

        if ($transaction) {
            $transactions = Transaction::latest()->get();
            return redirect()
                ->route('home', compact('transactions'))
                ->with([
                    'success' => 'Paid has been updated successfully'
                ]);
        } else {
            return redirect()
                ->route('home', compact('transactions'))
                ->with([
                    'error' => 'Some problem has occurred, please try again'
                ]);
        }
    }
}
