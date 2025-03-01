
class EpisodesDataModel  {
  String? name;
  String? slug;
  String? filename;
  String? link_embed;
  String? link_m3u8;


  EpisodesDataModel({
      this.name,
      this.slug,
      this.filename,
      this.link_embed,
      this.link_m3u8,});


  factory EpisodesDataModel.fromJson(Map<String, dynamic> json) {
    return EpisodesDataModel(
        name: json['name'],
        slug: json['slug'],
        filename: json['filename'],
        link_embed: json['link_embed'],
        link_m3u8: json['link_m3u8'],
    );
  }
}
