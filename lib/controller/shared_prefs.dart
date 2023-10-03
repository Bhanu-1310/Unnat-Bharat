import 'package:shared_preferences/shared_preferences.dart';

Future<String> loaduserTypeFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('userType') ?? '';
}

Future<void> saveuserTypeToSharedPreferences(String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userType', value);
}
