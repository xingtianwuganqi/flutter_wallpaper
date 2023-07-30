import 'package:flutter/material.dart';

import '../models/my_page_model.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPageState();
  }
}

class MyPageState extends State<MyPage> {
  List<MyPageModel> dataSources = [
    MyPageModel(icon: "",name: "用户信息"),
    MyPageModel(icon: "",name: "我的发布"),
    MyPageModel(icon: "",name: "我的收藏"),
    MyPageModel(icon: "",name: "=="),
    MyPageModel(icon: "",name: "用户协议"),
    MyPageModel(icon: "",name: "隐私协议"),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的"),
      ),
      body: ListView.builder(
        itemCount: dataSources.length,
          itemBuilder: (context, index){
            return null;
          }),
    );
  }
}