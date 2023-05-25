<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    public function response_success($data){
        return response()->json($data);
    }

    public function response_error($error, $status){
        return response()->json($error, $status);
    }

    public function response_badrequest($error){
        return response()->json($error, 400);
    }

    public function response_unauthorized(){
        return response()->json(["error"=>"unauthorized"], 403);
    }

    public function response_notfound(){
        return response()->json(["error"=>"not found"], 404);
    }
}
