<?php

namespace App\Http\Controllers;

use App\Models\Picture;
use App\Models\Produk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class ProdukController extends Controller
{
    public function get()
    {
        $produks = Produk::with(["user", "pic"])->get();
        return $this->response_success($produks);
    }

    public function getOne($id)
    {
        $produk = Produk::with(["user", "pic"])->find($id);
        if ($produk) {
            return $this->response_success($produk);
        }
        return $this->response_notfound();
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "price" => "required",
            "city" => "required",
            "pic" => "required"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        DB::beginTransaction();
        try {
            $data = $validation->safe()->only("pic");
            $picture = new Picture(["url" => $data["pic"]]);
            $picture->save();
            $data = $validation->safe()->only(["name", "price", "city"]);
            $data["user_id"] = Auth::user()->getAuthIdentifier();
            $data["picture_id"] = $picture->id;
            $produk = new Produk($data);
            $produk->save();
            DB::commit();
            return $this->response_success(["message" => "created", "id" => $produk->id]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }
}
