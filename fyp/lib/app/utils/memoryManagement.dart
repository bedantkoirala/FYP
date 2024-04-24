import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String? getAccessToken() {
    return prefs?.getString('token');
  }

  // Method to get favorites from memory storage
  static String? getFavorites() {
    return prefs?.getString('Favorites');
  }

  static void setAccessToken(String token) {
    prefs!.setString('token', token);
  }

  static void removeAccessToken() {
    prefs!.remove('token');
  }

  static saveDiscountPercentage(String percentage) {
    prefs!.setString('percentage', percentage);
  }

  static String? getDiscountPercentage() {
    return prefs?.getString('percentage');
  }

  static saveMembershipExpiry(String expiry) {
    prefs!.setString('expiry', expiry);
  }

  static String? getMembershipExpiry() {
    return prefs?.getString('expiry');
  }

  static String? getAccessRole() {
    return prefs?.getString('role');
  }

  static void setAccessRole(String token) {
    prefs!.setString('role', token);
  }

  static String? getMyCart() {
    return prefs?.getString('cart');
  }

  static void setMyCart(String cart) {
    prefs!.setString('cart', cart);
  }

  static String? getFavorite() {
    return prefs?.getString('favorite');
  }

  static void setFavorite(String favorite) {
    prefs!.setString('favorite', favorite);
  }

  static void removeAccessRole() {
    prefs!.remove('role');
  }

  static void removeAll() async {
    await prefs!.clear();
  }

  static void setFavorites(String jsonEncode) {}
}
