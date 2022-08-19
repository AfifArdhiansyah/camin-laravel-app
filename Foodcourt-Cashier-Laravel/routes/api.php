<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TenantApiController;
use App\Http\Controllers\FoodApiController;
use App\Http\Controllers\TransactionApiController;
use App\Http\Controllers\TransactionFoodApiController;

Route::get('/tenants/{username}/{password}', [TenantApiController::class, 'findTenant']);
Route::get('/tenants/all', [TenantApiController::class, 'allTenant']);

Route::post('create-food', [FoodApiController::class, 'createFood'])->name('create-food');
Route::post('edit-food/{id}', [FoodApiController::class, 'editFood'])->name('edit-food');
Route::get('/food/find/{tenant_id}', [FoodApiController::class, 'findFood']);
Route::get('/foods/all', [FoodApiController::class, 'allFood']);

Route::post('create-transaction', [TransactionApiController::class, 'createTransaction']);
Route::post('update-transaction/{id}', [TransactionApiController::class, 'updateTransaction']);

Route::post('create-transaction-food', [TransactionFoodApiController::class, 'createTransactionFood']);
Route::get('transaction-food/{id}', [TransactionFoodApiController::class, 'findTransactionFood']);

Route::post('store-transaction',[ TransactionApiController::class, 'storeTransaction']);

Route::get('history/{id}',[ TransactionApiController::class, 'getHistory']);
Route::get('set-served/{id}',[ TransactionApiController::class, 'setServed']);

Route::get('get-queue/{id}',[ TenantApiController::class, 'getQueue']);
Route::get('get-history/{id}',[ TenantApiController::class, 'getHistory']);
