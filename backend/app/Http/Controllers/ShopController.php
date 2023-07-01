<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ShopController extends Controller
{
    public function getAll() {
        $data = Shop::with(["user" => ["pic"], "products"])->get();
        return $this->response_success($data);
    }
    public function getByID($id) {
        $data = Shop::with(["user" => ["pic"], "products"])->firstWhere("id", $id);
        return $this->response_success($data);
    }
    public function getByUserID($userId) {
        $data = Shop::with(["user" => ["pic"], "products"])->firstWhere("user_id", $userId);
        return $this->response_success($data);
    }
    public function create(Request $request) {
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "lt" => "required",
            "ln" => "required",
            "address" => "required",
            "description" => "required"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $data = $validation->safe()->all();
        $data["user_id"] = Auth::user()->getAuthIdentifier();
        $shop = new Shop($data);
        $shop->save();
        return $this->response_success(["message"=>"created", "data"=>$shop]);
    }

    public function edit(Request $request){
        if (Auth::user()->shop == null){
            return $this->response_error(["error"=>"don't have shop"], 403);
        }
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "lt" => "required",
            "ln" => "required",
            "address" => "required",
            "description" => "required"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $data = $validation->safe()->all();
        $shop = Shop::where("user_id", Auth::user()->getAuthIdentifier())->first();
        $shop->name = $data["name"];
        $shop->lt = $data["lt"];
        $shop->ln = $data["ln"];
        $shop->address = $data["address"];
        $shop->description = $data["description"];
        $shop->save();
        return $this->response_success(["message" => "updated", "data" => $shop]);
    }
}
