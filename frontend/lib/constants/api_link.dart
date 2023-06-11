class ApiLink {
  static const String hifarmBaseUrl = 'http://172.20.10.3:8000/api';
  static const String login = '$hifarmBaseUrl/login';

  static const String register = '$hifarmBaseUrl/register';
  static const String getPosts = '$hifarmBaseUrl/post';
  static const String getNews = '$hifarmBaseUrl/berita';
  static const String profile = '$hifarmBaseUrl/profile';
  static const String getProfile = '$profile/me';
  static const String mapsGeocode =
      'https://maps.googleapis.com/maps/api/geocode/json?';
}
