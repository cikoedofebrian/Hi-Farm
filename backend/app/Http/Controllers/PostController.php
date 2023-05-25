<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostCollection;
use App\Models\Picture;
use App\Models\Post;
use App\Models\PostTag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class PostController extends Controller
{
    public function get(Request $request)
    {
        $id = $request->input("id");
        if ($id) {
            $post = Post::with(["pics", "tags"=>["user"]])->firstWhere("id", $id);
            if ($post) {
                return $this->response_success($post);
            }
            return $this->response_notfound();
        } else {
            $posts = Post::with(["pics", "tags"=>["user"]])->get();
            return $this->response_success(PostCollection::collection($posts));
        }
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "description" => "required",
            "ln" => "required",
            "lt" => "required",
            "pics" => "required|array",
            "tags" => "required|array",
            "tags.*" => "exists:users,id",
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
                $postpic = new Picture(["url" => $pic, "post_id" => $post->id]);
                $postpic->save();
            }
            foreach ($data["tags"] as $tag) {
                $posttag = new PostTag(["user_id" => $tag, "post_id" => $post->id]);
                $posttag->save();
            }
            DB::commit();
            return $this->response_success(["message" => "posted"]);
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
            "tags" => "nullable|array",
            "tags.*" => "exists:users,id",
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
                    Picture::where("post_id", $post->id)->delete();
                    foreach ($data["pics"] as $pic) {
                        $postpic = new Picture(["url" => $pic, "post_id" => $post->id]);
                        $postpic->save();
                    }
                    PostTag::where("post_id", $post->id)->delete();
                    foreach ($data["tags"] as $tag) {
                        $posttag = new PostTag(["user_id" => $tag, "post_id" => $post->id]);
                        $posttag->save();
                    }
                    DB::commit();
                    return $this->response_success(["message" => "updated"]);
                } catch (Exception $e) {
                    DB::rollBack();
                    return $this->response_error(["error" => $e->getMessage()], 500);
                }
            }else{
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
