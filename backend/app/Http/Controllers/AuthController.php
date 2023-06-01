<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required|email|unique:users,email",
            "password" => "required|min:6|confirmed"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $data = $validation->validated();
        $data["password"] = Hash::make($data["password"]);
        $user = new User($data);
        $user->save();
        $credentials = $request->only("email", "password");
        $token = Auth::guard("api")->attempt($credentials);
        return $this->response_success(["auth_token"=>$token]);
    }

    public function login(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "email" => "required|email|exists:users",
            "password" => "required|min:6"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        if ($token = Auth::guard("api")->attempt($validation->validated())) {
            return $this->response_success(["auth_token"=>$token]);
        }
        return $this->response_badrequest(["password" => ["The password field confirmation does not match."]]);
    }
}
