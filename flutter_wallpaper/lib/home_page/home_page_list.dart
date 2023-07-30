import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_basic/base_tools.dart';
import 'package:flutter_wallpaper/home_page/edit_page.dart';

import '../mine/my_page.dart';
import '../models/home_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageListPage extends StatefulWidget {
  const HomePageListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageListPageState();
  }
}

class HomePageListPageState extends State<HomePageListPage> {
  
  List<EditInfoModel> listModels = [
    EditInfoModel(isAdd: 1),
  ];

  final String EDITKEY = "userEditList";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataSources();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const MyPage();
            }));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
      ),itemCount: listModels.length,
          itemBuilder: (context, index) {
          var item = listModels[index];
          if (item.isAdd == 1) {
            return addItem();
          }else{
            return contentItem(item);
          }
        }
      )
    );
  }

  Widget contentItem(EditInfoModel edit) {
    return Container(
      color: ColorsUtil.hexColor(edit.backColor ?? ""),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(edit.descText ?? "",style: TextStyle(fontSize: 12,
            color: ColorsUtil.hexColor(edit.textColor ?? ""),
          // fontFamily: edit.,
          overflow: TextOverflow.clip,
        ),maxLines: null,
        ),
      ),

    );
  }

  Widget addItem() {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return EditPage(changed: (value) {
              setState(() {

              });
            });
          }));
        },
      ),
    );
  }

  // 读取本地数据
  Future<void> readDataSources() async {
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    List<String>? list = preferences.getStringList(EDITKEY);
    if (list != null) {
      print("本地有数据");
      List<EditInfoModel> editList = [];
      for (var element in list) {
        var jsonMap = jsonDecode(element);
        print(jsonMap);
        var editModel = EditInfoModel.fromJson(jsonMap);
        editList.add(editModel);
      }
      listModels.addAll(editList);
      setState(() {

      });
    }
  }
}