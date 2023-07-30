
class HomePageListModel {
  final String? imgUrl;
  final int? createTime;
  final bool? isAdd;
  final EditInfoModel? editModel;

  HomePageListModel({
    this.imgUrl,
    this.createTime,
    this.isAdd,
    this.editModel
  });

  factory HomePageListModel.fromJson(Map<String, dynamic> json) {
    return HomePageListModel(
      imgUrl: json["imgUrl"],
      createTime: json["createTime"],
      isAdd: false,
      editModel: EditInfoModel.fromJson(json["editInfo"])
    );
  }

  Map<String, dynamic> toJson() {
    HomePageListModel listModel = this;
    return <String, dynamic> {
      "imgUrl": listModel.imgUrl,
      "createTime": listModel.createTime,
      "isAdd": listModel.isAdd,
      "editModel": listModel.editModel?.toJson(),
    };
  }

}



class EditInfoModel {
  String? editId;
  String? descText;
  String? textType;
  double? textFontSize;
  double? rowHeight;
  String? textColor;
  String? backColor;
  int? isAdd = 0;
  // String? rColor;
  // String? gColor;
  // String? bColor;

  EditInfoModel({
    this.editId,
    this.descText,
    this.textType,
    this.textFontSize,
    this.rowHeight,
    this.textColor,
    this.backColor,
    this.isAdd,
    // this.rColor,
    // this.gColor,
    // this.bColor
  });

  factory EditInfoModel.fromJson(Map<String, dynamic> json) {
    return EditInfoModel(
      editId: json["editId"],
      descText: json["descText"],
      textType: json["textType"],
      textFontSize: json["textFontSize"],
      rowHeight: json["rowHeight"],
      textColor: json["textColor"],
      backColor: json["backColor"],
      isAdd: 0,
      // rColor: json["rColor"],
      // gColor: json["gColor"],
      // bColor: json["bColor"],
    );
  }

  Map<String, dynamic> toJson() {
    EditInfoModel infoModel = this;
    return <String, dynamic> {
      "editId": infoModel.editId,
      "descText": infoModel.descText,
      "textType": infoModel.textType,
      "textFontSize": infoModel.textFontSize,
      "rowHeight": infoModel.rowHeight,
      "textColor": infoModel.textColor,
      "backColor": infoModel.backColor,
      "isAdd": infoModel.isAdd,
    };
  }
}