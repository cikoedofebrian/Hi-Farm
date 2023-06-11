<?php

namespace App\Http\Controllers;

use App\Models\DetailOrder;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class OrderController extends Controller
{
    public function get(){
        $orders = Order::with(["detailOrder"=>["product"=>["pic"], "deletedProduct"=>["pic"]], "user", "shop"])->where("user_id", Auth::user()->getAuthIdentifier())->get();
        return $this->response_success($orders);
    }
    public function getOne($id)
    {
        $order = Order::with(["detailOrder"=>["product"=>["pic"], "deletedProduct"=>["pic"]], "user", "shop"])->where("user_id", Auth::user()->getAuthIdentifier())->find($id);
        if ($order) {
            return $this->response_success($order);
        }
        return $this->response_notfound();
    }
    public function getShop() {
        $orders = Order::with(["detailOrder"=>["product"=>["pic"], "deletedProduct"=>["pic"]], "user", "shop"])->where("shop_id", Auth::user()->shop->id)->get();
        return $this->response_success($orders);
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "payment" => "required",
            "shop_id" => "required",
            "list_order" => "required|array",
            "list_order.*.product_id" => "required|exists:products,id",
            "list_order.*.qty" => "required"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        DB::beginTransaction();
        try {
            $data = $validation->safe()->only(["payment", "shop_id"]);
            $data["user_id"] = Auth::user()->getAuthIdentifier();
            $order = new Order($data);
            $order->save();
            $data = $validation->safe()->only("list_order");
            foreach ($data["list_order"] as $orderItem) {
                $orderItem["order_id"] = $order->id;
                $item_n = new DetailOrder($orderItem);
                $item_n->save();
            }
            DB::commit();
            $order = Order::with(["detailOrder"=>["product"=>["pic"], "deletedProduct"=>["pic"]], "user", "shop"])->find($order->id);
            return $this->response_success(["message" => "created", "data" => $order]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }
}
