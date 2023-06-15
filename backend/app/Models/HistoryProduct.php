<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistoryProduct extends Model
{
    use HasFactory;
    protected $fillable = [
        "name", "description", "price", "city", "shop_id", "picture_id"
    ];

    protected $hidden = [
        "created_at",
        "updated_at"
    ];

    public function shop(){
        return $this->belongsTo(Shop::class, "shop_id");
    }

    public function pic(){
        return $this->belongsTo(Picture::class, "picture_id");
    }
}
