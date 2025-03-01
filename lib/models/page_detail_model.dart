
class PageDetailModel  {
  String? og_type;
  String? titleHead;
  String? descriptionHead;
  String? og_url;
  List? list_og_image;


  PageDetailModel({
      this.og_type,
      this.titleHead,
      this.descriptionHead,
      this.og_url,
      this.list_og_image});

  factory PageDetailModel.fromJson(Map<String, dynamic> json) {
    return PageDetailModel(
      og_type: json['og_type'],
      titleHead: json['titleHead'],
      descriptionHead: json['descriptionHead'],
      og_url: json['og_url'],
      list_og_image: json['og_image'],
    );
  }

}
