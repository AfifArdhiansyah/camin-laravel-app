<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CashierController;


Route::get('/', [CashierController::class, 'index'])->name('home');
Route::get('/history', [CashierController::class, 'history'])->name('history');
Route::get('/tenant', [CashierController::class, 'tenant'])->name('tenant');

//ceate tenant
Route::get('post-tenant', [CashierController::class, 'createTenant']);
Route::post('store-tenant', [CashierController::class, 'storeTenant']);

//delete tenant
Route::get('delete/tenant/{id}', [CashierController::class, 'destroyTenant']);

//update tenant
Route::get('edit-tenant/{id}', [CashierController::class, 'toEdit']);
Route::put('update-tenant/{id}', [CashierController::class, 'updateTenant'])->name('update-tenant');

//set paid
Route::put('set-paid/{id}', [CashierController::class, 'setPaid'])->name('set-paid');

Route::get('/linkstorage', function () {
    Artisan::call('storage:link');
});