import 'package:hifarm/constants/api_key.dart';

class ApiLink {
  static const String hifarmBaseUrl = 'http://172.20.10.3:8000/api';
  static const String login = '$hifarmBaseUrl/login';
  static const String register = '$hifarmBaseUrl/register';
  static const String getPosts = '$hifarmBaseUrl/post';
  static const String getNews = '$hifarmBaseUrl/news';
  static const String getComment = '$hifarmBaseUrl/comment';
  static const String searchPosts = '$getPosts/k';
  static const String searchProduct = '$getProducts/k';
  static const String profile = '$hifarmBaseUrl/profile';
  static const String getProfile = '$profile/me';
  static const String baseMaps = 'https://maps.googleapis.com/maps/api';
  static const String mapsComplete = '$baseMaps/place/autocomplete/json?input=';
  static const String key = '&key=$GOOGLE_MAPS_API_KEY';
  static const String language = '&language=id';
  static const String getShop = '$hifarmBaseUrl/shop';
  static const String mapsDetails = '$baseMaps/place/details/json?placeid=';
  static const String getProducts = '$hifarmBaseUrl/product';
  static const String mapsGeocode =
      'https://maps.googleapis.com/maps/api/geocode/json?';
  static const String getOrder = '$hifarmBaseUrl/order';
}
