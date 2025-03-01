
class CountryItemModel  {
  String? id;
  String? name;
  String? slug;


  CountryItemModel({
    this.id,
    this.name,
    this.slug,});


  factory CountryItemModel.fromJson(Map<String, dynamic> json) {
    return CountryItemModel(
      id: json['id'],
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
