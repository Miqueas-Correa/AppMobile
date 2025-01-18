import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final String apiUrl = dotenv.env['API_URL'] ?? '';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
}