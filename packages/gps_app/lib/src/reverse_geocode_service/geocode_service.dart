import '../reverse_geocode.dart';
import 'revers_geo_api_client.dart';

class GeocodeService {
  final ReverseGeoApiClient _reversGeoApiClient = ReverseGeoApiClient();
  Future<ReverseGeocode> getAddress(
      {required double lon, required double lat}) async {
    return (await _reversGeoApiClient.getAddress(lat: lat, lon: lon));
  }
}
