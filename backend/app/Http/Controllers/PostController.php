<?php

namespace App\Http\Controllers;

use App\Models\Picture;
use App\Models\Post;
use App\Models\PostPicture;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class PostController extends Controller
{
    public function get()
    {
        $posts = Post::with(["pics", "user"])->get();
        return $this->response_success($posts);
    }

    public function getOne($id)
    {
        $post = Post::with(["pics", "user"])->find($id);
        if ($post) {
            return $this->response_success($post);
        }
        return $this->response_notfound();
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "description" => "required",
            "ln" => "required",
            "lt" => "required",
            "pics" => "required|array"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $data = $validation->validated();
        DB::beginTransaction();
        try {
            $postData = $validation->safe()->only(['description', 'ln', 'lt']);
            $postData["user_id"] = Auth::id();
            $post = new Post($postData);
            $post->save();
            foreach ($data["pics"] as $pic) {
                $picture = new Picture(["url" => $pic, "post_id" => $post->id]);
                $picture->save();
                $postpic = new PostPicture(["post_id" => $post->id, "picture_id" => $picture->id]);
                $postpic->save();
            }
            DB::commit();
            return $this->response_success(["message" => "posted", "id" => $post->id]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }

    public function edit($id, Request $request)
    {
        $validation = Validator::make($request->all(), [
            "description" => "required",
            "ln" => "required",
            "lt" => "required",
            "pics" => "required|array",
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $post = Post::find($id);
        if ($post) {
            if ($post->user_id === Auth::id()) {
                $data = $validation->validated();
                DB::beginTransaction();
                try {
                    $post->description = $data["description"];
                    $post->ln = $data["ln"];
                    $post->lt = $data["lt"];
                    $post->save();
                    PostPicture::where("post_id", $post->id)->with("pic")->delete();
                    foreach ($data["pics"] as $pic) {
                        $picture = new Picture(["url" => $pic, "post_id" => $post->id]);
                        $picture->save();
                        $postpic = new PostPicture(["post_id" => $post->id, "picture_id" => $picture->id]);
                        $postpic->save();
                    }
                    DB::commit();
                    return $this->response_success(["message" => "updated", "id" => $post->id]);
                } catch (Exception $e) {
                    DB::rollBack();
                    return $this->response_error(["error" => $e->getMessage()], 500);
                }
            } else {
                return $this->response_unauthorized();
            }
        } else {
            return $this->response_notfound();
        }
    }

    public function delete($id)
    {
        $post = Post::find($id);
        if ($post) {
            if ($post->user_id === Auth::id()) {
                $post->delete();
                return $this->response_success(["message" => "deleted"]);
            }
            return $this->response_unauthorized();
        } else {
            return $this->response_notfound();
        }
    }
}
