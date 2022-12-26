class Links {
  Links({
      this.href,
      this.rel, 
      this.render,});

  Links.fromJson(dynamic json) {
    href = json['href'];
    rel = json['rel'];
    render = json['render'];
  }
  String? href;
  String? rel;
  String? render;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = href;
    map['rel'] = rel;
    map['render'] = render;
    return map;
  }

}