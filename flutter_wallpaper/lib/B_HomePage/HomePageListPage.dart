import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/B_HomePage/EditPage.dart';

class HomePageListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageListPageState();
  }
}

class HomePageListPageState extends State<HomePageListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: IconButton(icon: const Icon(Icons.abc_outlined), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const EditPage();
          }));
        },),
      )
    );
  }
}