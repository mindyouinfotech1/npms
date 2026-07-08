import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {

  static String get googleApiKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
}