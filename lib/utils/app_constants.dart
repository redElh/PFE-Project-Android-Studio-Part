class AppConstants{
  static const String APP_NAME="The Best Food";
  static const int APP_VERSION=1;
  static const String BASE_URL="http://192.168.1.40:8001";
  static const String POPULAR_PRODUCT_URI="/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI="/api/v1/products/recommended";
  //static const String DRINKS_URI="/api/v1/products/drinks";
  static const String UPLOAD_URL="/uploads/";
  static const String SEND_ORDER="/api/v1/send-order-email";

  //user and auth endpoints
  static const String REGISTRATION_URI="/api/v1/auth/register";
  static const String LOGIN_URI="/api/v1/auth/login";
  static const String USER_INFO_URI="/api/v1/customer/info";

  static const String USER_ADDRESS="user_address";
  static const String GEOCODE_URI='/api/v1/config/geocode-api';

  static const String TOKEN="";
  static const String PHONE="";
  static const String PASSWORD="";
  static const String EMAIL="smtp.gmail.com";
  static const String EMAIL2="redaelhiri9@gmail.com";
  static const String PASSWORD2="Rida123@Light";

  static const String CART_LIST="Cart-list";
  static const String CART_HISTORY_LIST="Cart-history-list";
}