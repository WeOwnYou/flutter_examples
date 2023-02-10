class ReverseGeocode {
  List<Suggestions>? suggestions;

  ReverseGeocode({this.suggestions});

  ReverseGeocode.fromJson(Map<String, dynamic> json) {
    if (json['suggestions'] != null) {
      suggestions = <Suggestions>[];
      json['suggestions'].forEach((v) {
        suggestions!.add(Suggestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (suggestions != null) {
      data['suggestions'] = suggestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suggestions {
  String? value;
  String? unrestrictedValue;
  Data? data;

  Suggestions({this.value, this.unrestrictedValue, this.data});

  Suggestions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unrestrictedValue = json['unrestricted_value'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unrestricted_value'] = unrestrictedValue;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? postalCode;
  String? country;
  String? countryIsoCode;
  String? regionFiasId;
  String? regionKladrId;
  String? regionIsoCode;
  String? regionWithType;
  String? regionType;
  String? regionTypeFull;
  String? region;
  String? cityFiasId;
  String? cityKladrId;
  String? cityWithType;
  String? cityType;
  String? cityTypeFull;
  String? city;
  String? streetFiasId;
  String? streetKladrId;
  String? streetWithType;
  String? streetType;
  String? streetTypeFull;
  String? street;
  String? houseFiasId;
  String? houseKladrId;
  String? houseType;
  String? houseTypeFull;
  String? house;
  String? fiasId;
  String? fiasLevel;
  String? fiasActualityState;
  String? kladrId;
  String? geonameId;
  String? capitalMarker;
  String? okato;
  String? oktmo;
  String? taxOffice;
  String? taxOfficeLegal;
  String? geoLat;
  String? geoLon;
  String? qcGeo;

  Data(
      {this.postalCode,
        this.country,
        this.countryIsoCode,
        this.regionFiasId,
        this.regionKladrId,
        this.regionIsoCode,
        this.regionWithType,
        this.regionType,
        this.regionTypeFull,
        this.region,
        this.cityFiasId,
        this.cityKladrId,
        this.cityWithType,
        this.cityType,
        this.cityTypeFull,
        this.city,
        this.streetFiasId,
        this.streetKladrId,
        this.streetWithType,
        this.streetType,
        this.streetTypeFull,
        this.street,
        this.houseFiasId,
        this.houseKladrId,
        this.houseType,
        this.houseTypeFull,
        this.house,
        this.fiasId,
        this.fiasLevel,
        this.fiasActualityState,
        this.kladrId,
        this.geonameId,
        this.capitalMarker,
        this.okato,
        this.oktmo,
        this.taxOffice,
        this.taxOfficeLegal,
        this.geoLat,
        this.geoLon,
        this.qcGeo,});

  Data.fromJson(Map<String, dynamic> json) {
    postalCode = json['postal_code'];
    country = json['country'];
    countryIsoCode = json['country_iso_code'];
    regionFiasId = json['region_fias_id'];
    regionKladrId = json['region_kladr_id'];
    regionIsoCode = json['region_iso_code'];
    regionWithType = json['region_with_type'];
    regionType = json['region_type'];
    regionTypeFull = json['region_type_full'];
    region = json['region'];
    cityFiasId = json['city_fias_id'];
    cityKladrId = json['city_kladr_id'];
    cityWithType = json['city_with_type'];
    cityType = json['city_type'];
    cityTypeFull = json['city_type_full'];
    city = json['city'];
    streetFiasId = json['street_fias_id'];
    streetKladrId = json['street_kladr_id'];
    streetWithType = json['street_with_type'];
    streetType = json['street_type'];
    streetTypeFull = json['street_type_full'];
    street = json['street'];
    houseFiasId = json['house_fias_id'];
    houseKladrId = json['house_kladr_id'];
    houseType = json['house_type'];
    houseTypeFull = json['house_type_full'];
    house = json['house'];
    fiasId = json['fias_id'];
    fiasLevel = json['fias_level'];
    fiasActualityState = json['fias_actuality_state'];
    kladrId = json['kladr_id'];
    geonameId = json['geoname_id'];
    capitalMarker = json['capital_marker'];
    okato = json['okato'];
    oktmo = json['oktmo'];
    taxOffice = json['tax_office'];
    taxOfficeLegal = json['tax_office_legal'];
    geoLat = json['geo_lat'];
    geoLon = json['geo_lon'];
    qcGeo = json['qc_geo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['country_iso_code'] = countryIsoCode;
    data['region_fias_id'] = regionFiasId;
    data['region_kladr_id'] = regionKladrId;
    data['region_iso_code'] = regionIsoCode;
    data['region_with_type'] = regionWithType;
    data['region_type'] = regionType;
    data['region_type_full'] = regionTypeFull;
    data['region'] = region;
    data['city_fias_id'] = cityFiasId;
    data['city_kladr_id'] = cityKladrId;
    data['city_with_type'] = cityWithType;
    data['city_type'] = cityType;
    data['city_type_full'] = cityTypeFull;
    data['city'] = city;
    data['street_fias_id'] = streetFiasId;
    data['street_kladr_id'] = streetKladrId;
    data['street_with_type'] = streetWithType;
    data['street_type'] = streetType;
    data['street_type_full'] = streetTypeFull;
    data['street'] = street;
    data['house_fias_id'] = houseFiasId;
    data['house_kladr_id'] = houseKladrId;
    data['house_type'] = houseType;
    data['house_type_full'] = houseTypeFull;
    data['house'] = house;
    data['fias_id'] = fiasId;
    data['fias_level'] = fiasLevel;
    data['fias_actuality_state'] = fiasActualityState;
    data['kladr_id'] = kladrId;
    data['geoname_id'] = geonameId;
    data['capital_marker'] = capitalMarker;
    data['okato'] = okato;
    data['oktmo'] = oktmo;
    data['tax_office'] = taxOffice;
    data['tax_office_legal'] = taxOfficeLegal;
    data['geo_lat'] = geoLat;
    data['geo_lon'] = geoLon;
    data['qc_geo'] = qcGeo;
    return data;
  }
}