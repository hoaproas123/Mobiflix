class DropdownModel {
  DropdownModel({
    this.value,
    this.label,
  });

  String? value;
  String? label;

  factory DropdownModel.fromMap(Map<String, dynamic> json) => DropdownModel(
        value: json["value"],
        label: json["label"],
      );
}
