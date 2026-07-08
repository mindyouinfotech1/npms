import 'package:dio/dio.dart';

import '../config/app_config.dart';


class AddressLocationModel {
  final String formattedAddress;
  final double latitude;
  final double longitude;

  AddressLocationModel({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });
}

class GeocodingService {
  final Dio _dio = Dio();
  final key = AppConfig.googleApiKey;

  Future<AddressLocationModel?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        queryParameters: {
          "latlng": "$latitude,$longitude",
          "key": key,
        },
      );

      if (response.statusCode == 200 &&
          response.data["status"] == "OK") {
        final result = response.data["results"][0];

        return AddressLocationModel(
          formattedAddress: result["formatted_address"],
          latitude: latitude,
          longitude: longitude,
        );
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}