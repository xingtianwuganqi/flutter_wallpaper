
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter_basic/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_info/platform_info.dart';
import 'home_page_model.dart';
import 'package:flutter_printer/flutter_printer.dart';
import 'package:device_info_plus/device_info_plus.dart';


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

  // 截屏的key
  //全局key
  GlobalKey _boundaryKey = GlobalKey();
  List<Uint8List> _images = [];


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

  // ///截图
  Future<Uint8List?> _capturePng(
      GlobalKey globalKey, {
        double pixelRatio = 1.0, //截屏的图片与原图的比例
      }) async {
    try {
      RenderRepaintBoundary? boundary =
      globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary?.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image?.toByteData(format: ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 保存图片
  void savePhoto() async {
    RenderRepaintBoundary? boundary = _boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //获取保存相册权限，如果没有，则申请改权限
    bool permition = await getPormiation();
    if (permition) {
      var status = await Permission.photos.status;
      if (Platform.instance.isIOS) {
        if (status.isGranted) {
          Uint8List images = byteData!.buffer.asUint8List();
          final result = await ImageGallerySaver.saveImage(images,
              quality: 60, name: "hello");
          EasyLoading.showToast("保存成功");
        }
        if (status.isDenied) {
          print("IOS拒绝");
          EasyLoading.showToast("您拒绝授权");
        }
      } else {
        //安卓
        if (Platform.instance.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          if (androidInfo.version.sdkInt <= 32) {
            /// use [Permissions.storage.status]
            var status = await Permission.storage.status;
            if (status.isGranted) {
              Printer.printMapJsonLog('Android已授权');
              Uint8List images = byteData!.buffer.asUint8List();
              final result = await ImageGallerySaver.saveImage(images, quality: 60);
              if (result != null) {
                EasyLoading.showToast("保存成功");
              } else {
                EasyLoading.showToast("保存失败");
              }
            }else{
              EasyLoading.showToast("您未授权，请授权后重试");
            }
          }  else {
            /// use [Permissions.photos.status]
            var status = await Permission.photos.status;
            if (status.isGranted) {
              Printer.printMapJsonLog('Android已授权');
              Uint8List images = byteData!.buffer.asUint8List();
              final result = await ImageGallerySaver.saveImage(images, quality: 60);
              if (result != null) {
                EasyLoading.showToast("保存成功");
              } else {
                EasyLoading.showToast("保存失败");
              }
            }else{
              Printer.printMapJsonLog('Android未授权');
              EasyLoading.showToast("您未授权，请授权后重试");
            }
          }
        }

      }
    }else{
      //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
      savePhoto();
    }
  }

  //申请存本地相册权限
  Future<bool> getPormiation() async {
    if (Platform.instance.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
        ].request();
        // saveImage(globalKey);
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
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
              backColorWidget(),
              saveButtonWidget()
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
              child:
              RepaintBoundary(
                key: _boundaryKey,
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
      height: 80 + statusBarHeight,
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

    // var listView = SliverFixedExtentList(
    //   itemExtent: statusBarHeight + 120, //列表项高度固定
    //   delegate: SliverChildBuilderDelegate(
    //         (_, index) {
    //       return textContainer;
    //     },
    //     childCount: 1,
    //   ),
    // );
    var listView = SliverToBoxAdapter(
      child: textContainer,
    );
    return listView;
  }

  // 字体选择框
  Widget textTypeSelectWidget() {
    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10,right: 10),
      // height: 70,
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
    var listView = SliverToBoxAdapter(
      child: dropDown,
    );
    return listView;
  }

  // 文字大小选择
  Widget textFontSizeWidget() {
    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10),
      // height: 70,
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
    var listView = SliverToBoxAdapter(
      child: dropDown,
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
    var listView = SliverToBoxAdapter(
      child: dropDown,
    );
    return listView;
  }


  // 行间距大小选择
  Widget textLineSizeWidget() {
    var sliderWidget = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      // padding: const EdgeInsets.only(left: 10),
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
    var listView = SliverToBoxAdapter(
      child: sliderWidget,
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
    var listView = SliverToBoxAdapter(
      child: dropDown,
    );
    return listView;
  }

  Widget saveButtonWidget() {

    var dropDown = Container(
      margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
      padding: const EdgeInsets.only(left: 10,right: 10),
      height: 50,
      child:
      TextButton(
        child: const Text('保存到相册'),
        onPressed: () {
          savePhoto();
        },
      )
    );
    var listView = SliverToBoxAdapter(
      child: dropDown,
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