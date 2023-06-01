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

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function pics(){
        return $this->hasManyThrough(Picture::class, PostPicture::class, "post_id", "id", "id", "picture_id");
    }

    public function user(){
        return $this->belongsTo(User::class);
    }
}
