<?php

namespace App\Http\Controllers;

use App\Models\News;
use App\Models\Picture;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class NewsController extends Controller
{
    public function get()
    {
        $news = News::with(["pic"])->orderBy("created_at", "desc")->get();
        return $this->response_success($news);
    }

    public function getOne($id)
    {
        $news = News::with(["pic"])->find($id);
        if ($news) {
            return $this->response_success($news);
        }
        return $this->response_notfound();
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "title" => "required",
            "description" => "required",
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
            $data = $validation->safe()->only(["title", "description"]);
            $data["picture_id"] = $picture->id;
            $news = new News($data);
            $news->save();
            DB::commit();
            $news = News::with("pic")->find($news->id);
            return $this->response_success(["message" => "created", "data" => $news]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }
}
