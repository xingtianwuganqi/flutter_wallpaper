
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
  double appBarAlpha = 0;
  double appOffset = 100;
  final FocusNode _userFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  // 字体样式
  List<String> textTypeList = ["斜体","粗体","黑体","宋体"];
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
  double _sliderValue = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.editInfo ??= EditInfoModel();
    _controller.addListener(() {
      print(_controller.text);
    });
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
                color: (widget.editInfo?.backColor ?? "#FFC0CB").hexColor,
                child: Text(widget.editInfo?.descText ?? "鉴于对人权的无视和侮蔑已发展为野蛮暴行,这些暴行玷污了人类的良心,而一个人人享有言论和信仰自由并免予恐惧和匮乏的世界的来临,已被宣布为普通人民的最高愿望",
                  style: TextStyle(fontSize: widget.editInfo?.textFontSize ?? 16,
                  color: (widget.editInfo?.textColor ?? "#333333").hexColor,
                  fontFamily: widget.editInfo?.textType ?? "MaShan"
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
        items: textTypeList.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
        onChanged: (newPosition){
          setState(() {

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
            padding: EdgeInsets.only(left: 5,right: 5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            height: 50,
            width: 50,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                GestureDetector(child: Container(
                  width: 44,
                  height: 26,
                  child:  Icon(Icons.arrow_drop_up_rounded),
                )),
                GestureDetector(child: Container(
                  width: 44,
                  height: 26,
                  child:  Icon(Icons.arrow_drop_down_rounded),
                )),
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
                  print(newPosition);
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
                setState(() {

                });
              },
              isExpanded: true,
              value: backColorList.first,
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