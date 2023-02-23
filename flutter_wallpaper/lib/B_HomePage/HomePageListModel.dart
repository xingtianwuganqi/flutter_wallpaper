
class HomePageListModel {
  final String? imgUrl;
  final int? createTime;
  final bool? isAdd;

  HomePageListModel({
    this.imgUrl,
    this.createTime,
    this.isAdd,
  });

  factory HomePageListModel.fromJson(Map<String, dynamic> json) {
    return HomePageListModel(
      imgUrl: json["imgUrl"],
      createTime: json["createTime"],
      isAdd: false
    );
  }
}