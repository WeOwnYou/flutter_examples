class Metadata {
  Metadata({
      this.totalHits,});

  Metadata.fromJson(dynamic json) {
    totalHits = json['total_hits'];
  }
  int? totalHits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_hits'] = totalHits;
    return map;
  }

}