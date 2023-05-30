import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/models/data/news_model.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        newsDetails,
        arguments: MNews(
            title:
                'HARGA ANJLOK, ASN DINAS PERTANIAN BORONG CABAI PETANI LOKAL',
            body:
                'BLORA. Anjloknya harga cabai merah saat musim panen disikapi Dinas Pertanian dan Ketahanan Pangan Kabupaten Blora dengan memborong langsung dari petani. Jumat pagi (18/1), beberapa petani dari Desa Purworejo membawa ratusan kilogram cabai merah segar yang baru saja dipetik ke Dinas Pertanian dan Ketahanan Pangan.Setibanya di Dinas Pertanian dan Ketahanan Pangan, ratusan kilogram cabai merah segar dalam karung plastik langsung ditumpahkan di pelataran untuk dibungkusi dan dikemas masing-masing dua kilogram dan satu kilogram. Kepala Dinas Pertanian dan Ketahanan Pangan, Ir. Reni Miharti M.Agr.Bus ikut langsung dalam proses pembungkusan cabai merah segar ini bersama sejumlah pegawai yang ada di kantornya, untuk kemudian dibagikan kepada seluruh ASN.”Pembelian langsung dari petani ini sebagai salah satu upaya untuk menstabilkan harga cabai merah. Pasalnya harga beli para tengkulak ke petani hanya sekitar Rp 8.000,00 hingga Rp 9.000,00 per kilogram. Dengan harga segitu, petani merugi. Kami ingin menolong para petani,” ucap Reni. Kali ini pihaknya membeli langsung ke petani dengan harga yang lebih layak, yakni Rp 14.000,00 per kilogramnya. Sehingga petani bisa mendapatkan keuntungan lebih besar.”Sesuai arahan Bapak Bupati melalui Sekretaris Daerah yang meminta agar seluruh ASN ikut turun andil dalam penstabilan harga cabai dengan membeli langsung dari petani. Sehingga kami bersama-sama seluruh ASN mengawalinya dengan membeli 200 kilogram. Secara bertahap, dinas OPD lainnya juga akan melakukan hal yang sama,” lanjut Reni. Jika hal ini berhasil dilakukan, diharapkan harga cabai kembali normal dan para tengkulak tidak seenaknya sendiri menentukan harga komoditas hortikultura. Sehingga petani bisa menikmati hasil panennya dengan baik. Sukirno dan Fikri, para petani dari Gapoktan Bina Tani Desa Purworejo, Kecamatan Blora, yang mengantarkan cabai merah ke Dinas Pertanian dan Ketahanan Pangan mengaku senang karena hasil tanamannya bisa terbeli dengan harga tinggi sehingga bisa menikmati keuntungan.”Kemarin tengkulak hanya memberi harga Rp 9.000,00 per kilogram. Tidak menutup biaya produksi, malah rugi. Alhamdulillah ini dipesan Dinas Pertanian dan dibeli dengan harga Rp 14.000,00 per kilogramnya sehingga sudah mendapatkan keuntungan,” ucap Sukirno.',
            image: 'assets/home_images/image 1.png'),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
          height: 140,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/home_images/image 1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 140,
                height: 140,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'HARGA ANJLOK, ASN DINAS PERTANIAN BORONG CABAI PETANI LOKAL',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Expanded(
                      child: Text(
                        'BLORA. Anjloknya harga cabai merah saat musim panen disikapi Dinas Pertanian dan Ketahanan Pangan Kabupaten Blora dengan memborong langsung dari petani. Jumat pagi (18/1), beberapa petani dari Desa Purworejo membawa ratusan kilogram cabai merah segar yang baru saja dipetik ke Dinas Pertanian dan Ketahanan Pangan.Setibanya di Dinas Pertanian dan Ketahanan Pangan, ratusan kilogram cabai merah segar dalam karung plastik langsung ditumpahkan di pelataran untuk dibungkusi dan dikemas masing-masing dua kilogram dan satu kilogram.',
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
