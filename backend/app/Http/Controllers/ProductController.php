<?php

namespace App\Http\Controllers;

use App\Models\DetailOrder;
use App\Models\HistoryProduct;
use App\Models\Picture;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class ProductController extends Controller
{
    public function get()
    {
        $products = Product::with(["shop", "pic"])->get();
        return $this->response_success($products);
    }

    public function getOne($id)
    {
        $product = Product::with(["shop", "pic"])->find($id);
        if ($product) {
            return $this->response_success($product);
        }
        return $this->response_notfound();
    }
    public function getByKeyword($keyword) {
        $product = Product::with(["shop", "pic"])->where("name", "like", "%$keyword%")->get();
        return $this->response_success($product);
    }

    public function create(Request $request)
    {
        if(Auth::user()->shop == null) {
            return $this->response_error(["error"=>"don't have shop"], 403);
        }
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
            $data["shop_id"] = Auth::user()->shop->id;
            $data["picture_id"] = $picture->id;
            $product = new Product($data);
            $product->save();
            DB::commit();
            $product = Product::with(["shop"=>["user"], "pic"])->find($product->id);
            return $this->response_success(["message" => "created", "data" => $product]);
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
            $product = Product::find($id);
            if (Auth::user()->shop->id !== $product->shop_id) {
                return $this->response_unauthorized();
            }
            $data = $validation->safe()->only(["name", "price", "city"]);
            $product->name = $data["name"];
            $product->price = $data["price"];
            $product->city = $data["city"];
            if ($request->input("pic")) {
                $data = $validation->safe()->only("pic");
                $picture = new Picture(["url" => $data["pic"]]);
                $picture->save();
                $product->picture_id = $picture->id;
            }
            $product->save();
            DB::commit();
            $product = Product::with(["shop"=>["user"], "pic"])->find($product->id);
            return $this->response_success(["message" => "updated", "data" => $product]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }

    public function delete($id)
    {
        $product = Product::find($id);
        if ($product) {
            if (Auth::user()->shop->id !== $product->shop_id) {
                return $this->response_unauthorized();
            }
            $history = new HistoryProduct([
                "name" => $product->name,
                "price" => $product->price,
                "city" => $product->city,
                "shop_id" => $product->shop_id,
                "picture_id" => $product->picture_id
            ]);
            $history->save();
            DetailOrder::where("product_id", $product->id)->update(["history_product_id"=>$history->id, "product_id"=>null]);
            $product->delete();
            return $this->response_success(["message" => "deleted", "history_id" => $history->id]);
        }
        return $this->response_notfound();
    }

    public function getHistory(){
        $histories = HistoryProduct::where("shop_id", Auth::user()->shop->id)->with(["pic", "shop"])->get();
        return $this->response_success($histories);
    }

    public function getHistoryOne($id)
    {
        $history = HistoryProduct::where("shop_id", Auth::user()->shop->id)->with(["shop", "pic"])->find($id);
        if ($history) {
            return $this->response_success($history);
        }
        return $this->response_notfound();
    }
}
