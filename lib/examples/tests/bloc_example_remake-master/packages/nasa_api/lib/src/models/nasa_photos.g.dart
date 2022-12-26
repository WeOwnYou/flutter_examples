import 'collection.g.dart';

class NasaPhotos {
  NasaPhotos({
      this.collection,});

  NasaPhotos.fromJson(Map<String, dynamic> json) {
    collection = json['collection'] != null ? Collection.fromJson(json['collection']) : null;
  }
  Collection? collection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (collection != null) {
      map['collection'] = collection!.toJson();
    }
    return map;
  }

}