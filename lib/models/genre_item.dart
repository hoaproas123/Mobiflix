
class GenreItemModel  {
  String? id;
  String? name;
  String? slug;


  GenreItemModel({
      this.id,
      this.name,
      this.slug,});


  factory GenreItemModel.fromJson(Map<String, dynamic> json) {
    return GenreItemModel(
        id: json['_id'],
        name: json['name'],
        slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
