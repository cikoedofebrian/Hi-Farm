<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PostPicture extends Model
{
    use HasFactory;
    protected $fillable = [
      "post_id", "picture_id"
    ];

    public function pic(){
        return $this->belongsTo(Picture::class);
    }
}
