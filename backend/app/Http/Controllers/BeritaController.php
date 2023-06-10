<?php

namespace App\Http\Controllers;

use App\Models\Berita;
use App\Models\Picture;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Exception;

class BeritaController extends Controller
{
    public function get()
    {
        $beritas = Berita::with(["pic"])->selectRaw("id, judul, SUBSTR(description, 1, 100) as description, picture_id")->get();
        return $this->response_success($beritas);
    }

    public function getOne($id)
    {
        $berita = Berita::with(["pic"])->find($id);
        if ($berita) {
            return $this->response_success($berita);
        }
        return $this->response_notfound();
    }

    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            "judul" => "required",
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
            $data = $validation->safe()->only(["judul", "description"]);
            $data["picture_id"] = $picture->id;
            $berita = new Berita($data);
            $berita->save();
            DB::commit();
            $berita = Berita::with("pic")->find($berita->id);
            return $this->response_success(["message" => "created", "data" => $berita]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }
}
