
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/A_Common/extension/string_extension.dart';

import 'HomePageListModel.dart';

class EditPage extends StatefulWidget {

  final Function(EditInfoModel) changed;
  EditInfoModel? editInfo;
  EditPage({super.key,this.editInfo,required this.changed});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();
  double appOffset = 100;
  final FocusNode _userFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  double _fontSize = 20;

  // 字体样式
  List<String> textTypeList = ["MaShan","NotaSans","NotaSerif"];

  // 字体颜色
  List<String> textColorList = ["#333333","#006400", "#CD853F"];
  // 背景色
  /*
  	粉红
  	适中的板岩暗蓝灰色
  	纯蓝
  	石板灰
  	道奇蓝
  	深青色
  	纯绿
  	金色
  	橙色
  	深橙色
  	巧克力色
  	马鞍棕色
  	纯红
  	白色
  	灰色
  	纯黑
   */
  List<String> backColorList = ["#FFC0CB", "#7B68EE", "#0000FF","#708090","#1E90FF","#008B8B", "#008000",
    "#FFD700","#FFA500","#FF8C00","#D2691E","#8B4513","#FF0000","#FFFFFF","#808080","#000000"];
  // 行间距值
  double _sliderValue = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.editInfo ??= EditInfoModel(
      descText: "鉴于对人类家庭所有成员的固有尊严及其平等的和不移的权利的承认,乃是世界自由、正义与和平的基础",
      textType: "MaShan",
      textFontSize: _fontSize,
      rowHeight: _sliderValue,
      textColor: textColorList.first,
      backColor: backColorList.first,
    );
    // 设置默认值
    _controller.text = widget.editInfo?.descText ?? "";
    _fontSize = widget.editInfo?.textFontSize ?? 20;
    _sliderValue = widget.editInfo?.rowHeight ?? 2;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _userFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading:
      IconButton(onPressed: (){
        Navigator.pop(context);
      },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
      actions: [
        IconButton(onPressed: (){
          _scaffoldKey.currentState?.openEndDrawer();
        }, icon: const Icon(Icons.settings)),
      ],
    );
    return Scaffold(
      key: _scaffoldKey,
      endDrawer:  Drawer(
        child: GestureDetector(
          child: CustomScrollView(
            slivers: [
              textInputWidget(appBar.preferredSize.height),
              textTypeSelectWidget(),
              textFontSizeWidget(),
              textColorWidget(),
              textLineSizeWidget(),
              backColorWidget()
            ],
          ),
          onTap: () {
            _userFocusNode.unfocus();
          },
        ),
      ),
      body:
      Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // 监听列表的滚动
              child: Container(
                padding: const EdgeInsets.only(left: 30,right: 30),
                alignment: Alignment.center,
                color: (widget.editInfo?.backColor)?.hexColor,
                child: Text(widget.editInfo?.descText ?? "",
                  style: TextStyle(fontSize: widget.editInfo?.textFontSize,
                  color: (widget.editInfo?.textColor)?.hexColor,
                  fontFamily: widget.editInfo?.textType
                  ),
                  strutStyle: StrutStyle(forceStrutHeight: true, height: widget.editInfo?.rowHeight ?? 2),
                ),
              )
          ),
          SizedBox(
            height: appBar.preferredSize.height + 40,
            child: appBar,
          ),
        ],
      ),
    );
  }

  // 文本输入框
  Widget textInputWidget(double statusBarHeight) {
    var textContainer = Container(
      margin: EdgeInsets.only(top: statusBarHeight,left: 15,right: 15),
      height: 100 + statusBarHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: "#E8EBF2".hexColor),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: TextField(
          controller: _controller,
          focusNode: _userFocusNode,
          maxLines: 5,
          decoration: const InputDecoration(
              hintText: "请输入文本",
              border: InputBorder.none
          ),
          onChanged: (text) {
            widget.editInfo?.descText = text;
            setState(() {

            });
          },
        ),
      ),
    );

    var listView = SliverFixedExtentList(
      itemExtent: statusBarHeight + 120, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return textContainer;
        },
        childCount: 1,
      ),
    );
    return listView;
  }

  // 字体选择框
  Widget textTypeSelectWidget() {
    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10,right: 10),
      height: 70,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: "#E8EBF2".hexColor),
          color: Colors.white
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none
        ),
        items: textTypeList.map((e) => DropdownMenuItem(value: e,child: Text(e,style: TextStyle(fontFamily: e),),)).toList(),
        onChanged: (newPosition){
          setState(() {
            widget.editInfo?.textType = newPosition;
          });
        },
        isExpanded: true,
        value: textTypeList.first,
      ),
    );
    var listView = SliverFixedExtentList(
      itemExtent: 70, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return dropDown;
        },
        childCount: 1,
      ),
    );
    return listView;
  }

  // 文字大小选择
  Widget textFontSizeWidget() {
    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10),
      height: 70,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: "#E8EBF2".hexColor),
          color: Colors.white
      ),
      child: Row(
        children: [
          const Text("字体大小"),
          Expanded(child: Container(),),
          Container(
            padding: const EdgeInsets.only(left: 5,right: 5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            height: 50,
            width: 50,
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none
              ),
              controller: TextEditingController.fromValue(TextEditingValue(text: "$_fontSize")),
              textAlign: TextAlign.center,
              enabled: false,
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                GestureDetector(child: Container(
                  width: 44,
                  height: 26,
                  child:  const Icon(Icons.arrow_drop_up_rounded),
                ),onTap: () {
                  _fontSize += 1;
                  setState(() {
                    widget.editInfo?.textFontSize = _fontSize;
                  });
                },
                ),
                GestureDetector(child: Container(
                  width: 44,
                  height: 26,
                  child:  const Icon(Icons.arrow_drop_down_rounded),
                ),onTap: () {
                  if (_fontSize > 0) {
                    _fontSize -= 1;
                    setState(() {
                      widget.editInfo?.textFontSize = _fontSize;
                    });
                  }
                },
                ),
              ],
            )
          )
        ],
      ),
    );
    var listView = SliverFixedExtentList(
      itemExtent: 70, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return dropDown;
        },
        childCount: 1,
      ),
    );
    return listView;
  }

  // 字体颜色
  Widget textColorWidget() {
    var colors = textColorList.map((e) {
      var w = Container(padding: const EdgeInsets.only(
          left: 15, right: 15, top: 5, bottom: 5), color: e.hexColor,);
      return DropdownMenuItem(value: e, child: w);
    });

    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10,right: 10),
      height: 95,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: "#E8EBF2".hexColor),
          color: Colors.white
      ),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10),
              child: Text("字体颜色"),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  border: InputBorder.none
              ),
              items: colors.toList(),
              onChanged: (newPosition){
                setState(() {
                  if (kDebugMode) {
                    print(newPosition);
                  }
                  if (newPosition != null) {
                    widget.editInfo?.textColor = newPosition;
                  }
                });
              },
              isExpanded: true,
              value: textColorList.first,
            )
          ]
      ),
    );
    var listView = SliverFixedExtentList(
      itemExtent: 95, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return dropDown;
        },
        childCount: 1,
      ),
    );
    return listView;
  }


  // 行间距大小选择
  Widget textLineSizeWidget() {
    var sliderWidget = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      // padding: const EdgeInsets.only(left: 10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: "#E8EBF2".hexColor),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 10, top: 10),
            child: Text("行间距"),
          ),
          Slider(
            min:  2,
            max:  12,
            divisions: 10,
            label: _sliderValue.toString(),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey.withOpacity(0.3),
            value: _sliderValue,
            onChanged: (value) {
              _sliderValue = value;
              widget.editInfo?.rowHeight = _sliderValue;
              setState(() {

              });
            }
          )
        ],
      ),
    );
    var listView = SliverFixedExtentList(
      itemExtent: 100, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return sliderWidget;
        },
        childCount: 1,
      ),
    );
    return listView;
  }

  // 背景色
  Widget backColorWidget() {
    var colors = backColorList.map((e) {
      var w = Container(padding: const EdgeInsets.only(
          left: 15, right: 15, top: 15, bottom: 15), color: e.hexColor,);
      return DropdownMenuItem(value: e, child:
      w);
    });

    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10,right: 10),
      height: 95,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: "#E8EBF2".hexColor),
          color: Colors.white
      ),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10),
            child: Text("背景颜色"),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  border: InputBorder.none
              ),
              items: colors.toList(),
              onChanged: (newPosition){
                if (newPosition != null) {
                  widget.editInfo?.backColor = newPosition;
                }
                setState(() {

                });
              },
              isExpanded: true,
              value: widget.editInfo?.backColor ?? backColorList.first,
            )
          ]
        ),
    );
    var listView = SliverFixedExtentList(
      itemExtent: 95, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return dropDown;
        },
        childCount: 1,
      ),
    );
    return listView;
  }

  void updateEditModel() {

  }
}


class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Container(
          color: Colors.white,
          child: TextField(

          ),
        ),
      ),
    );
  }
}