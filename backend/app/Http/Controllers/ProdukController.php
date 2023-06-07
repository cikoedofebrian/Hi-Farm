<?php

namespace App\Http\Controllers;

use App\Models\HistoryBarang;
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
            $produk = Produk::with(["user", "pic"])->find($produk->id);
            return $this->response_success(["message" => "created", "data" => $produk]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }

    public function edit($id, Request $request)
    {
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "price" => "required",
            "city" => "required",
            "pic" => "nullable"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        DB::beginTransaction();
        try {
            $produk = Produk::find($id);
            if (Auth::user()->getAuthIdentifier() !== $produk->user_id) {
                return $this->response_unauthorized();
            }
            $data = $validation->safe()->only(["name", "price", "city"]);
            $produk->name = $data["name"];
            $produk->price = $data["price"];
            $produk->city = $data["city"];
            if ($request->input("pic")) {
                $data = $validation->safe()->only("pic");
                $picture = new Picture(["url" => $data["pic"]]);
                $picture->save();
                $produk->picture_id = $picture->id;
            }
            $produk->save();
            DB::commit();
            $produk = Produk::with(["user", "pic"])->find($produk->id);
            return $this->response_success(["message" => "updated", "data" => $produk]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }

    public function delete($id)
    {
        $produk = Produk::find($id);
        if ($produk) {
            if (Auth::user()->getAuthIdentifier() !== $produk->user_id) {
                return $this->response_unauthorized();
            }
            $history = new HistoryBarang([
                "name" => $produk->name,
                "price" => $produk->price,
                "city" => $produk->city,
                "user_id" => $produk->user_id,
                "picture_id" => $produk->picture_id
            ]);
            $history->save();
            $produk->delete();
            return $this->response_success(["message" => "deleted", "history_id" => $history->id]);
        }
        return $this->response_notfound();
    }

    public function getHistory(){
        $histories = HistoryBarang::where("user_id", Auth::user()->getAuthIdentifier())->with(["pic", "user"])->get();
        return $this->response_success($histories);
    }

    public function getHistoryOne($id)
    {
        $history = HistoryBarang::where("user_id", Auth::user()->getAuthIdentifier())->with(["user", "pic"])->find($id);
        if ($history) {
            return $this->response_success($history);
        }
        return $this->response_notfound();
    }
}
