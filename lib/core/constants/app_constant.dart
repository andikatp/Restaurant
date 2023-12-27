class AppConstant {
  AppConstant._();

  //network stuff
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  static const int successfulHttpGetStatusCode = 200;
  static const int successfulHttpPostStatusCode = 201;

  // assets
  static const String imageUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const String userImagePath = 'assets/logo/german.png';
  static const String logoPath = 'assets/logo/logo.svg';
  static const String searchLottie = 'assets/json/search.json';
  static const String emptyLottie = 'assets/json/empty.json';


  // error message
  static const String noInternetConnection = 'Please check your connection';
  static const String serverFailureMessage =
      'Ups, API Error. please try again!';
  static const String generalFailureMessage = 'Ups, check your connection';

  // others
  static const String hintText = 'Search...';
  static const String searchText = 'Start Searching Here..';
  static const String addCommentText = 'Add Comment';
}
