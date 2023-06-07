<?php

namespace App\Http\Controllers;

use App\Models\Alamat;
use App\Models\DetailPesanan;
use App\Models\Pesanan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PHPUnit\Exception;

class PesananController extends Controller
{
    public function get()
    {
        $pesanans = Pesanan::with(["detailPesanan", "alamat"])->where("user_id", Auth::user()->getAuthIdentifier())->get();
        return $this->response_success($pesanans);
    }
    public function getOne($id)
    {
        $oesanan = Pesanan::with(["detailPesanan", "alamat"])->where("user_id", Auth::user()->getAuthIdentifier())->find($id);
        if ($oesanan) {
            return $this->response_success($oesanan);
        }
        return $this->response_notfound();
    }
    public function create(Request $request)
    {
        $validated = $this->validate($request, [
            "alamat_id" => "required",
            "pembayaran" => "required",
            "list_pesanan" => "required|array",
            "list_pesanan.*.produk_id" => "required|exists:produks,id",
            "list_pesanan.*.qty" => "required"
        ]);
        DB::beginTransaction();
        try {
            $data = $validated->safe()->only(["alamat_id", "pembayaran"]);
            $data["user_id"] = Auth::user()->getAuthIdentifier();
            $pesanan = new Pesanan($data);
            $pesanan->save();
            $data = $validated->safe()->only("list_pesanan");
            foreach ($data["list_pesanan"] as $itempesanan) {
                $itempesanan["pesanan_id"] = $pesanan->id;
                $item_n = new DetailPesanan($itempesanan);
                $item_n->save();
            }
            DB::commit();
            return $this->response_success(["message" => "ordered", "id" => $pesanan->id]);
        } catch (Exception $e) {
            DB::rollBack();
            return $this->response_error(["error" => $e->getMessage()], 500);
        }
    }

    public function getAlamat()
    {
        $alamats = Alamat::where("user_id", Auth::user()->getAuthIdentifier())->get();
        return $this->response_success($alamats);
    }

    public function createAlamat(Request $request)
    {
        $validation = $this->validate($request, [
            "name", "address", "phone"
        ]);
        $data = $validation->getData();
        $data["user_id"] = Auth::user()->getAuthIdentifier();
        $alamat = new Alamat($data);
        $alamat->save();
        return $this->response_success(["message" => "created", "id" => $alamat->id]);
    }
}
