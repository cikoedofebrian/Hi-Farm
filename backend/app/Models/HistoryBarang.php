<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistoryBarang extends Model
{
    use HasFactory;
    protected $fillable = [
        "name", "price", "city", "user_id", "picture_id"
    ];

    protected $hidden = [
        "created_at",
        "updated_at"
    ];

    public function user(){
        return $this->belongsTo(User::class, "user_id");
    }

    public function pic(){
        return $this->belongsTo(Picture::class, "picture_id");
    }
}
