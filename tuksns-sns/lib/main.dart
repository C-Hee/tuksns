
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sns_flutter/src/app.dart';
void main() async {
  //main함수에서 비동기사용을 위해 필요한 메서드
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString ('token');
  runApp(MyApp(token));
}

