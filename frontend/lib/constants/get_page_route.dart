import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/views/screens/authentication/login_screen.dart';
import 'package:hifarm/views/screens/authentication/onboarding_screen.dart';
import 'package:hifarm/views/screens/authentication/register_screen.dart';
import 'package:hifarm/views/screens/features/home/feed/add_location.dart';
import 'package:hifarm/views/screens/features/home/feed/add_new_post.dart';
import 'package:hifarm/views/screens/features/home/feed/post_details.dart';
import 'package:hifarm/views/screens/features/home/home.dart';
import 'package:hifarm/views/screens/features/home/news/news_details.dart';
import 'package:hifarm/views/screens/features/home/shop/add_address.dart';
import 'package:hifarm/views/screens/features/home/shop/complete_order.dart';
import 'package:hifarm/views/screens/features/home/shop/create_product.dart';
import 'package:hifarm/views/screens/features/home/shop/create_shop.dart';
import 'package:hifarm/views/screens/features/home/shop/estimation_time.dart';
import 'package:hifarm/views/screens/features/home/shop/product_view.dart';
import 'package:hifarm/views/screens/features/home/shop/shop_with_products.dart';
import 'package:hifarm/views/screens/features/home/shop/transaction_details.dart';
import 'package:hifarm/views/screens/features/home/shop/transaction_list.dart';
import 'package:hifarm/views/screens/features/home/shop/transaction_success.dart';
import 'package:hifarm/views/screens/features/home/shop/view_address.dart';
import 'package:hifarm/views/screens/features/home/shop/view_cart.dart';
import 'package:hifarm/views/screens/features/home/shop/view_shop.dart';
import 'package:hifarm/views/screens/features/home/shop/view_shop_product.dart';
import 'package:hifarm/views/screens/features/search/search_location.dart';

final pageRoute = [
  GetPage(
    name: onboardingScreen,
    page: () => const OnboardingScreen(),
  ),
  GetPage(
    name: loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: registerScreen,
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: newsDetails,
    page: () => const NewsDetails(),
  ),
  GetPage(
    name: homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: addNewPost,
    page: () => const AddNewPost(),
  ),
  GetPage(
    name: postDetails,
    page: () => const PostDetails(),
  ),
  GetPage(
    name: addPostLocation,
    page: () => const AddLocation(),
  ),
  GetPage(
    name: newStore,
    page: () => const CreateShop(),
  ),
  GetPage(
    name: viewShop,
    page: () => const ViewShop(),
  ),
  GetPage(
    name: searchLocation,
    page: () => const SearchLocation(),
  ),
  GetPage(
    name: createProduct,
    page: () => const CreateProduct(),
  ),
  GetPage(
    name: viewCart,
    page: () => const ViewCart(),
  ),
  GetPage(
    name: transactionSuccess,
    page: () => const TransactionSuccess(),
  ),
  GetPage(
    name: productList,
    page: () => const ViewShopProduct(),
  ),
  GetPage(
    name: shopWithProducts,
    page: () => const ShopWithProducts(),
  ),
  GetPage(
    name: productView,
    page: () => const ProductView(),
  ),
  GetPage(
    name: estimationTime,
    page: () => const EstimationTime(),
  ),
  GetPage(
    name: addressView,
    page: () => const ViewAddress(),
  ),
  GetPage(
    name: addAddress,
    page: () => const AddAddress(),
  ),
  GetPage(
    name: completeOrder,
    page: () => const CompleteOrder(),
  ),
  GetPage(
    name: userTransactionList,
    page: () => const TransactionList(),
  ),
  GetPage(
    name: transactionDetails,
    page: () => const TransactionDetails(),
  ),
];
