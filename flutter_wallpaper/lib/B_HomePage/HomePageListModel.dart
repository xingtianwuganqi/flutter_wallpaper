
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



class EditInfoModel {
  String? descText;
  String? textType;
  double? textFontSize;
  double? rowHeight;
  String? textColor;
  String? backColor;
  String? rColor;
  String? gColor;
  String? bColor;

  EditInfoModel({
    this.descText,
    this.textType,
    this.textFontSize,
    this.rowHeight,
    this.textColor,
    this.backColor,
    this.rColor,
    this.gColor,
    this.bColor
  });

  factory EditInfoModel.fromJson(Map<String, dynamic> json) {
    return EditInfoModel(
      descText: json["descText"],
      textType: json["textType"],
      textFontSize: json["textFontSize"],
      rowHeight: json["rowHeight"],
      textColor: json["textColor"],
      backColor: json["backColor"],
      rColor: json["rColor"],
      gColor: json["gColor"],
      bColor: json["bColor"],
    );
  }

}