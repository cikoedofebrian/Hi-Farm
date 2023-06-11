<?php

namespace App\Http\Controllers;

use App\Models\Picture;
use App\Models\Post;
use App\Models\PostComment;
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
        $posts = Post::with(["pics", "user"=>["pic"], "comments"=>["user"=>["pic"]]])->get();
        return $this->response_success($posts);
    }

    public function getOne($id)
    {
        $post = Post::with(["pics", "user"=>["pic"], "comments"=>["user"=>["pic"]]])->find($id);
        if ($post) {
            return $this->response_success($post);
        }
        return $this->response_notfound();
    }
    public function getByKeyword($keyword)
    {
        $posts = Post::with(["pics", "user"=>["pic"], "comments"=>["user"=>["pic"]]])->where("description", "like", "%$keyword%")->get();
        return $this->response_success($posts);
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
            $post = Post::with(["pics", "user"=>["pic"]])->find($post->id);
            return $this->response_success(["message" => "created", "data" => $post]);
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
                    $post = Post::with(["pics", "user"=>["pic"]])->find($post->id);
                    return $this->response_success(["message" => "updated", "data" => $post]);
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
            PostPicture::where("post_id", $post->id)->delete();
            PostComment::where("post_id", $post->id)->delete();
            if ($post->user_id === Auth::id()) {
                $post->delete();
                return $this->response_success(["message" => "deleted"]);
            }
            return $this->response_unauthorized();
        } else {
            return $this->response_notfound();
        }
    }

    public function postComment($postId, Request $request)
    {
        $validation = Validator::make($request->all(), [
            "comment" => "required"
        ]);
        if ($validation->fails()) {
            return $this->response_badrequest($validation->errors());
        }
        $post = Post::find($postId);
        if ($post) {
            try {
                $comment = new PostComment([
                    "user_id" => Auth::user()->getAuthIdentifier(),
                    "post_id" => $post->id,
                    "comment" => $validation->validated()["comment"]
                ]);
                $comment->save();
                $comment = PostComment::with(["user"=>["pic"]])->find($comment->id);
                return $this->response_success(["message" => "created", "data" => $comment]);
            } catch (Exception $e) {
                return $this->response_error(["errors" => $e->getMessage()], 500);
            }
        } else {
            return $this->response_notfound();
        }
    }

    public function getComment($postId){
        $comments = PostComment::with(["user"=>["pic"]])->where("post_id", $postId)->get();
        if($comments){
            return $this->response_success($comments);
        }else{
            return $this->response_notfound();
        }
    }
}
