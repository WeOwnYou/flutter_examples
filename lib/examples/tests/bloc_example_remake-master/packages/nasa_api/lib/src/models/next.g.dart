class Next {
  Next({
      this.rel,
      this.prompt, 
      this.href,});

  Next.fromJson(dynamic json) {
    rel = json['rel'];
    prompt = json['prompt'];
    href = json['href'];
  }
  String? rel;
  String? prompt;
  String? href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rel'] = rel;
    map['prompt'] = prompt;
    map['href'] = href;
    return map;
  }

}