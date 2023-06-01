<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;
    protected $fillable = [
        "description",
        "ln",
        "lt",
        "user_id"
    ];

    public function pics(){
        return $this->hasMany(Picture::class);
    }

    public function user(){
        return $this->belongsTo(User::class);
    }
}
