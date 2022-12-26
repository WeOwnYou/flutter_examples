import 'items.g.dart';
import 'metadata.g.dart';
import 'next.g.dart';

class Collection {
  Collection({
      this.version,
      this.href, 
      this.items, 
      this.metadata, 
      this.next,});

  Collection.fromJson(dynamic json) {
    version = json['version'];
    href = json['href'];
    if (json['items'] != null) {
      items = [];
      json['items']!.forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['links'] != null) {
      next = [];
      json['links']!.forEach((v) {
        next!.add(Next.fromJson(v));
      });
    }
  }
  String? version;
  String? href;
  List<Items>? items;
  Metadata? metadata;
  List<Next>? next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['href'] = href;
    if (items != null) {
      map['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      map['metadata'] = metadata!.toJson();
    }
    if (next != null) {
      map['links'] = next!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}