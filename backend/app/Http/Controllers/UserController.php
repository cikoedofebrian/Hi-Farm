<?php

namespace App\Http\Controllers;

use App\Models\Picture;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class UserController extends Controller
{
    public function getMe(){
        $profile = User::with(["pic"])->find(Auth::user()->getAuthIdentifier());
        return $this->response_success($profile);
    }
    public function edit(Request $request){
        $validation = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "pic" => "nullable"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        try{
            $data = $validation->safe()->only(["name", "email", "pic"]);
            $profile = User::find(Auth::user()->getAuthIdentifier());
            $profile->name = $data["name"];
            $profile->email = $data["email"];
            if (isset($data["pic"])) {
                $picture = new Picture(["url" => $data["pic"]]);
                $picture->save();
                $profile->picture_id = $picture->id;
            }
            $profile->save();
            DB::commit();
            $profile = User::with(["pic"])->find(Auth::user()->getAuthIdentifier());
            return $this->response_success(["message" => "updated", "data" => $profile]);
        }catch (Exception $e){
            DB::rollback();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }
}
