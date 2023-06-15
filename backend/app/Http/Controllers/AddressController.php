<?php

namespace App\Http\Controllers;

use App\Models\Address;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AddressController extends Controller
{
    public function getAlamat()
    {
        $addresses = Address::where("user_id", Auth::user()->getAuthIdentifier())->get();
        return $this->response_success($addresses);
    }

    public function createAlamat(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "title", "lt", "ln", "address", "phone"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $data = $validation->getData();
        $data["user_id"] = Auth::user()->getAuthIdentifier();
        $address = new Address($data);
        $address->save();
        $address = Address::with(["user"])->find($address->id);
        return $this->response_success(["message" => "created", "data" => $address]);
    }
}
