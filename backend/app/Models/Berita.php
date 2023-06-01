<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Berita extends Model
{
    use HasFactory;
    protected $fillable = [
      "judul", "description", "picture_id"
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function pic(){
        return $this->belongsTo(Picture::class, "picture_id");
    }
}
