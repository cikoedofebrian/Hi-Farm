<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailPesanan extends Model
{
    use HasFactory;

    protected $fillable = [
        "pesanan_id", "produk_id", "qty"
    ];

    protected $hidden = [
        "created_at",
        "updated_at"
    ];
}
