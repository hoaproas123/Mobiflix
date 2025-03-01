
class PaginationModel  {
  int? currentPage;
  int? totalPages;
  String? slug;
  String? filterCategory;


  PaginationModel({
      this.slug,
      this.currentPage,
      this.totalPages,
      this.filterCategory});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['pagination']['currentPage'],
      totalPages: json['pagination']['totalPages'],
      slug: json['slug'],
      filterCategory: json['filterCategory'][0],
    );
  }

}
