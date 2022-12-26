import 'data.g.dart';
import 'links.g.dart';

class Items {
  Items({
      this.href,
      this.data, 
      this.links,});

  Items.fromJson(dynamic json) {
    href = json['href'];
    if (json['data'] != null) {
      data = [];
      json['data']!.forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = [];
      json['links']!.forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }
  String? href;
  List<Data>? data;
  List<Links>? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = href;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map['links'] = links!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}