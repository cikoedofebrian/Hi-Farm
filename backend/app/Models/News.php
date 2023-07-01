<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    use HasFactory;
    protected $fillable = [
      "title", "description", "picture_id"
    ];

    protected $hidden = [
        'updated_at',
    ];

    public function pic(){
        return $this->belongsTo(Picture::class, "picture_id");
    }
}
