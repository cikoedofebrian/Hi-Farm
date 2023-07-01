<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Shop extends Model
{
    use HasFactory;
    protected $fillable = [
      "user_id", "name", "lt", "ln", "address", "description"
    ];
    public function user() {
        return $this->belongsTo(User::class);
    }
    public function products() {
        return $this->hasMany(Product::class, "shop_id");
    }
}
