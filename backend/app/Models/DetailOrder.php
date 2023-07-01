<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailOrder extends Model
{
    use HasFactory;

    protected $fillable = [
        "order_id", "product_id", "history_product_id", "qty"
    ];

    protected $hidden = [
        "created_at",
        "updated_at"
    ];

    public function product() {
        return $this->belongsTo(Product::class);
    }
    public function deletedProduct() {
        return $this->belongsTo(HistoryProduct::class, "history_product_id");
    }
}
