
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/A_Common/extension/string_extension.dart';

class EditPage extends StatefulWidget {

  // VoidCallback changed;
  const EditPage({super.key});


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            textLineSizeWidget()
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
              child: Container(color: Colors.red)
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


  // 行间距大小选择
  Widget textLineSizeWidget() {
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
          const Text("行间距"),
          Expanded(child: Container(),),
          Container(
            padding: const EdgeInsets.only(left: 5,right: 5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            height: 50,
            width: 50,
            child: const TextField(

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
                    child:  const Icon(Icons.arrow_drop_up_rounded),
                  )),
                  GestureDetector(child: Container(
                    width: 44,
                    height: 26,
                    child:  const Icon(Icons.arrow_drop_down_rounded),
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