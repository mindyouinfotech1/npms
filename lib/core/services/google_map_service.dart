

import '../config/app_config.dart';

class GoogleMapService {

  Future<String> reverseGeocode(
      double lat,
      double lng) async {

    final key = AppConfig.googleApiKey;

    final url =
        "https://maps.googleapis.com/maps/api/geocode/json"
        "?latlng=$lat,$lng&key=$key";

    // Call API using Dio

    return "";
  }
}