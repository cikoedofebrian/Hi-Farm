import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/base/base_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/data/adddress_model.dart';
import 'package:hifarm/models/data/product_model.dart';
import 'package:hifarm/models/data/shop_model.dart';
import 'package:hifarm/models/data/transaction_model.dart';
import 'package:hifarm/models/page_data/cart_model.dart';
import 'package:hifarm/views/widgets/custom_snack_bar.dart';

class ShopController extends BaseController {
  Rx<MShop?> _shop = null.obs;
  MShop? get shop => _shop.value;
  void changeShop(MShop newShop) {
    _shop = newShop.obs;
  }

  final RxList<MCart> _cart = <MCart>[].obs;
  List<MCart> get cart => _cart;
  final RxList<MProduct> _productList = <MProduct>[].obs;
  List<MProduct> get productList => _productList;
  void clearShop() {
    _shop = null.obs;
  }

  Future<List<MAddress>> getAddress() async {
    List<MAddress> addressList = [];
    final getAddress = await ApiRequestSender.sendHttpRequest(
        ApiMethod.get, ApiLink.getAddress, null);
    for (var i in getAddress) {
      addressList.add(MAddress.fromJson(i));
    }
    return addressList;
  }

  Future<void> createAddress(
      String title, String phoneNum, LatLng? loc, String address) async {
    if (title.isEmpty || phoneNum.isEmpty || address.isEmpty || loc == null) {
      customSnackBar('Gagal', 'Data tidak boleh kosong!');
      return;
    } else if (int.tryParse(phoneNum) == null) {
      customSnackBar('Gagal', 'Data Tidak Valid');
      return;
    }

    await ApiRequestSender.sendHttpRequest(ApiMethod.post, ApiLink.getAddress, {
      'title': title,
      'address': address,
      'lt': loc.latitude,
      'ln': loc.longitude,
      'phone': phoneNum,
    });
    Get.back(result: true);
    customSnackBar('Berhasil', 'Alamat Berhasil Dibuat');
  }

  addToCart(MProduct product) {
    final productIndex =
        _cart.indexWhere((element) => element.shop.id == product.shop!.id);
    if (productIndex == -1) {
      _cart.add(MCart(shop: product.shop!, productList: [
        MInsideCart(product: product, quantity: 1),
      ]));
    } else {
      final prodIndex = _cart[productIndex]
          .productList
          .indexWhere((element) => element.product.id == product.id);
      if (prodIndex == -1) {
        _cart[productIndex]
            .productList
            .add(MInsideCart(product: product, quantity: 1));
      } else {
        _cart[productIndex].productList[prodIndex].quantity =
            _cart[productIndex].productList[prodIndex].quantity + 1;
      }
    }
    _cart.refresh();
  }

  int getTotalCartProduct() {
    int total = 0;
    for (var i in _cart) {
      for (var _ in i.productList) {
        total += 1;
      }
    }
    return total;
  }

  int getTotalCartPrice() {
    int total = 0;
    for (var i in _cart) {
      for (var j in i.productList) {
        total += j.quantity * j.product.price;
      }
    }
    return total;
  }

  bool validateTransaction(MAddress? address, String payment) {
    if (address == null || payment.isEmpty) {
      customSnackBar('Gagal', 'Data tidak boleh kosong');
      return false;
    }
    if (getTotalCartProduct() <= 0) {
      customSnackBar('Produk yang dipilih kosong!',
          'Tambahkan produk untuk melakukan transaksi');
      return false;
    }
    return true;
  }

  Future<void> createTransaction(String payment, int addressId) async {
    try {
      for (var i in cart) {
        List<Map<String, dynamic>> productIdList = [];
        for (var j in i.productList) {
          productIdList.add({
            'product_id': j.product.id,
            'qty': j.quantity,
          });
        }
        await ApiRequestSender.sendHttpRequest(
            ApiMethod.post, ApiLink.getOrder, {
          'shop_id': i.shop.id,
          'payment': payment,
          'address_id': addressId,
          'list_order': productIdList,
        });
      }
      _cart.clear();
      _cart.refresh();
    } catch (err) {
      // print(err);
    }
  }

  Future<List<MProduct>> getShopProducts(int id) async {
    List<MProduct> tempList = [];

    final String url = "${ApiLink.getProducts}/s/$id";
    final getData =
        await ApiRequestSender.sendHttpRequest(ApiMethod.get, url, null);
    for (var i in getData) {
      tempList.add(MProduct.fromJson(i));
    }
    return tempList;
  }

  decreaseFromCart(MProduct product) {
    final selectedShop =
        _cart.indexWhere((element) => element.shop.id == product.shop!.id);
    final selectedProduct = _cart[selectedShop]
        .productList
        .indexWhere((element) => element.product.id == product.id);

    if (_cart[selectedShop].productList[selectedProduct].quantity == 1) {
      removeFromCart(selectedShop, selectedProduct);
      if (_cart[selectedShop].productList.isEmpty) {
        _cart.removeAt(selectedShop);
        _cart.refresh();
      }
    } else {
      _cart[selectedShop].productList[selectedProduct].quantity =
          _cart[selectedShop].productList[selectedProduct].quantity - 1;
      _cart.refresh();
    }
  }

  final Rx<String> _lastSearched = ''.obs;
  String get lastSearched => _lastSearched.value;

  void changeLastSearch(String text) {
    _lastSearched.value = text;
  }

  MInsideCart getCartProduct(int shopId, int prodId) {
    final selectedShop =
        _cart.indexWhere((element) => element.shop.id == shopId);
    return _cart[selectedShop]
        .productList
        .firstWhere((element) => element.product.id == prodId);
  }

  Future<void> searchProduct(String searchText) async {
    if (searchText == lastSearched) {
      return;
    }
    changeLoading(true);
    if (searchText.isEmpty) {
      fetchProduct();
    } else {
      final searchUrl = "${ApiLink.searchProduct}/$searchText";
      List<MProduct> temporaryList = [];
      final searchResult = await ApiRequestSender.sendHttpRequest(
          ApiMethod.get, searchUrl, null);
      for (var i in searchResult) {
        temporaryList.add(MProduct.fromJson(i));
      }
      _productList.value = temporaryList;
      _productList.refresh();
      changeLoading(false);
    }
    changeLastSearch(searchText);
  }

  removeFromCart(int shopIndex, int index) {
    _cart[shopIndex].productList.removeAt(index);
    _cart.refresh();
  }

  Future<void> createProduct(
    String name,
    String price,
    File? photo,
    String description,
  ) async {
    if (name.isEmpty || price.isEmpty || photo == null || description.isEmpty) {
      customSnackBar('Gagal', 'Data tidak boleh kosong');
      return;
    } else if (int.tryParse(price) == null) {
      customSnackBar('Gagal', 'Data tidak valid');
      return;
    }
    final fStorage = FirebaseStorage.instance.ref(
        '/product_images/${shop!.id}/$name${DateTime.now().toIso8601String()}');
    final upload = await fStorage.putFile(File(photo.path));
    final imageUrl = await upload.ref.getDownloadURL();
    ApiRequestSender.sendHttpRequest(ApiMethod.post, ApiLink.getProducts, {
      'name': name,
      'price': int.parse(price),
      'city': shop!.address,
      'pic': imageUrl,
      'description': description,
    });
    Get.back();
    customSnackBar('Berhasil!', 'Produk berhasil ditambahkan');
  }

  Future<void> fetchProduct() async {
    final request = await ApiRequestSender.sendHttpRequest(
        ApiMethod.get, ApiLink.getProducts, null);
    final List<MProduct> tempList = [];
    for (var i in request) {
      tempList.add(MProduct.fromJson(i));
    }
    _productList.value = tempList;
    _productList.refresh();
    changeLoading(false);
  }

  Future<void> createShop(
    String name,
    LatLng? loc,
    String address,
    String description,
  ) async {
    if (name.isEmpty || loc == null || address.isEmpty || description.isEmpty) {
      customSnackBar('Gagal', 'Data tidak boleh kosong');
      return;
    }
    final request = await ApiRequestSender.sendHttpRequest(
        ApiMethod.post, ApiLink.getShop, {
      'name': name,
      'lt': loc.latitude,
      'ln': loc.longitude,
      'address': address,
      'description': description,
    });
    if (request['message'] == 'created') {
      changeShop(
        MShop.fromJson(
          request['data'],
        ),
      );
    }
    Get.back();
    customSnackBar('Berhasil!', 'Toko berhasil dibuat');
  }

  Future<List<MTransaction>> getTransaction(bool isUser) async {
    try {
      List<MTransaction> tempList = [];
      final url = isUser ? ApiLink.getOrder : "${ApiLink.getOrder}/shop";
      final getTrx =
          await ApiRequestSender.sendHttpRequest(ApiMethod.get, url, null);
      for (var i in getTrx) {
        tempList.add(MTransaction.fromJson(i));
      }
      return tempList;
    } catch (err) {
      print(err);
      return [];
    }
  }
}
