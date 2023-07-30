class MyPageModel {
  String? icon;
  String? name;

  MyPageModel(
  {
    this.icon,
    this.name
  });

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    return MyPageModel(
      icon: json['icon'],
      name: json['name']
    );
  }
}