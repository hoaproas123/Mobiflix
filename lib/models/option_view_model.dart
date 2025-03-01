class OptionViewModel  {
  String? url;
  String? tag;
  String? optionName;
  String? type;
  OptionViewModel({
    this.url,
    this.tag,
    this.optionName,
    this.type
  });

  factory OptionViewModel.initial() {
    return OptionViewModel(url: '',);
  }

}
