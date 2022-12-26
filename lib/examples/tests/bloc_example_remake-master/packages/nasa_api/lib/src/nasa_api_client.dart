import 'package:dio/dio.dart';
import 'models/nasa_photos.g.dart';

class ImagesRequestFailure implements Exception {}

class ImagesNotFound implements Exception {}

class NasaApiClient {
  static const _baseUrl = 'https://images-api.nasa.gov/';
  final Dio _dio;
  NasaApiClient() : _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  Future<NasaPhotos> searchPhotos({
    required String searchName,
    required int pageIndex,
    required String keyword,
    required String nasaId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'search',
      queryParameters: <String, dynamic>{
        'q': searchName,
        'media_type': 'image',
        'page': pageIndex.toString(),
        'keywords': keyword,
        'nasa_id': nasaId,
      },
    );
    if (response.statusCode != 200 || response.data == null) {
      throw ImagesRequestFailure();
    }
    final nasaPhotos = NasaPhotos.fromJson(response.data!);
    if (nasaPhotos.collection?.items?.isEmpty ?? false) {
      throw ImagesNotFound();
    }
    return nasaPhotos;
  }
}
