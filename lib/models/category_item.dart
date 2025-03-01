
class CategoryItemModel  {
  String? id;
  String? name;
  String? slug;


  CategoryItemModel({
      this.id,
      this.name,
      this.slug,});


  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
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

  List<Object?> get props => [
        id,
        name,
      ];
}
