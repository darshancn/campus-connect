class ConstantUrl {
  static final ConstantUrl _appColors = ConstantUrl._internal();

  factory ConstantUrl() => _appColors;

  ConstantUrl._internal();
  static const String baseUrl = "https://ummaconnect.encureit.com/api/";
  static const String register = "register";
  static const String login = "login";
  static const String forgot_password = "forgot-password";
  static const String reset_password = "reset-password";
  static const String subscription_list = "subscription_list";
  static const String add_subscription = "add_subscription";
  static const String customer_profile = "customer_profile";
  static const String upload_customer_profile_image = "upload_customer_profile_image";
  static const String update_customer_info = "update_customer_info";
  static const String category_list = "category_list";
  static const String sub_category_list = "sub_category_list";
  static const String additional_details_list = "additional_details_list";
  static const String add_listing = "add_listing";
  static const String my_ads = "my_ads";
  static const String my_ads_listing_details = "my_ads_listing_details";
  static const String mark_as_archive = "mark_as_archive";
  static const String delete_image_and_video = "delete_image_and_video";
  static const String update_listing = "update_listing";
  static const String delete_listing = "delete_listing";
  static const String add_to_my_favourites = "add_to_my_favourites";
  static const String listing_by_category = "listing_by_category";
  static const String listing_details_by_category = "listing_details_by_category";
  static const String my_favourites = "my_favourites";
  static const String association_list = "association_list";
  static const String donation_list = "donation_list";
  static const String add_donation = "add_donation";
  static const String change_password = "change_password";
  static const String subscription_details = "subscription_details";
  static const String save_donation = "save_donation";
  static const String transaction_list = "transaction_list";
  static const String static_pages = "static_pages";
  static const String users_current_subscription = "users_current_subscription";
  static const String mark_as_sold_users_list = "mark_as_sold_users_list";
  static const String mark_as_sold = "mark_as_sold";

}