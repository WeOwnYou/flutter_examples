

import '../reverse_geocode.dart';
import 'network_client.dart';

class ReverseGeoApiClient {
  final NetworkClient _networkClient = NetworkClient();
  Future<ReverseGeocode> getAddress(
      {required double lat, required double lon}) {
    ReverseGeocode parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = ReverseGeocode.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
        'https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address',
        parser, {
      'token': '2f26e12d87f626a7f5d4e3e1a20a6577d48c94b3',
      'secret': 'e3abcf09989ee7ad41dee6be06567eb3d3db97e2 ',
      'lat': lat.toString(), //?
      'lon': lon.toString()
    });
    return result;
  }
}
