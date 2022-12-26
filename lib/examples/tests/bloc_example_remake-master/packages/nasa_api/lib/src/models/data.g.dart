class Data {
  Data({
      this.center,
      this.title, 
      this.nasaId, 
      this.dateCreated, 
      this.keywords, 
      this.mediaType, 
      this.description508, 
      this.secondaryCreator, 
      this.description,});

  Data.fromJson(dynamic json) {
    center = json['center'];
    title = json['title'];
    nasaId = json['nasa_id'];
    dateCreated = json['date_created'];
    keywords = json['keywords'] != null ? json['keywords'].cast<String>() : [];
    mediaType = json['media_type'];
    description508 = json['description_508'];
    secondaryCreator = json['secondary_creator'];
    description = json['description'];
  }
  String? center;
  String? title;
  String? nasaId;
  String? dateCreated;
  List<String>? keywords;
  String? mediaType;
  String? description508;
  String? secondaryCreator;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['center'] = center;
    map['title'] = title;
    map['nasa_id'] = nasaId;
    map['date_created'] = dateCreated;
    map['keywords'] = keywords;
    map['media_type'] = mediaType;
    map['description_508'] = description508;
    map['secondary_creator'] = secondaryCreator;
    map['description'] = description;
    return map;
  }

}