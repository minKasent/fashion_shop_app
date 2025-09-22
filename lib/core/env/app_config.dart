import 'flavor.dart';

class AppConfig{
  final Flavor flavor; // dev , staging , prod
  final String baseUrl; // https://api.dev.com , https://api.staging.com , https://api.prod.com

AppConfig({required this.flavor, required this.baseUrl});
}