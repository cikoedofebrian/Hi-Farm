<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pesanan extends Model
{
    use HasFactory;
    protected $fillable = [
        "user_id", "alamat_id", "pembayaran"
    ];

    public function alamat(){
        return $this->belongsTo(Alamat::class);
    }
    public function detailPesanan(){
        return $this->hasMany(DetailPesanan::class, "pesanan_id");
    }
}
