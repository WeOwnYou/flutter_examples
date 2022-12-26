import 'package:nasa_api/src/models/models.dart';
import 'package:nasa_api/src/nasa_api_client.dart';

class NasaService {
  final NasaApiClient _apiClient = NasaApiClient();
  static final NasaService instance = NasaService._();

  NasaService._();

  Future<List<NasaPhoto>> searchNasaPhotos({
    required String searchName,
    int pageIndex = 1,
    String keyword = '',
    String nasaId = '',
  }) async {
    final allData = (await _apiClient.searchPhotos(
      searchName: searchName,
      pageIndex: pageIndex,
      keyword: keyword,
      nasaId: nasaId,
    ))
        .collection!
        .items;
    final photos = allData!.map(_itemToPhoto).toList();
    return photos;
  }

  NasaPhoto _itemToPhoto(Items item) {
    return NasaPhoto(
      title: item.data!.first.title!,
      link: item.links!.first.href!,
      nasaId: item.data!.first.nasaId!,
      keywords: item.data!.first.keywords!,
      description: item.data!.first.description!,
    );
  }
}
