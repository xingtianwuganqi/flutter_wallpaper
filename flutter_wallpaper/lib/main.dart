import 'package:flutter/material.dart';
import 'package:flutter_basic/base_model.dart';
import 'package:flutter_basic/base_tabbar.dart';
import 'package:flutter_wallpaper/home_page/home_page_list.dart';
import 'package:flutter_wallpaper/mine/my_page.dart';
import 'package:flutter_wallpaper/show_list/show_page.dart';
import 'package:flutter_wallpaper/tabbar.dart';


//这里就是关键的代码，定义一个key
final GlobalKey<BaseTabBarState> childTabViewKey = GlobalKey<BaseTabBarState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: createTabbar(),
    );
  }

  Widget createTabbar() {
    List<Widget> pages = [const HomePageListPage(),const ShowPageListPage(),const MyPage()];
    List<BottomNavigationModel> items = [
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_home_se@3x.png", unSelectIcon: "assets/icons/icon_tab_home_un@3x.png", title: "首页", isSelect: false, unreadNum: 0),
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_jh_se@3x.png", unSelectIcon: "assets/icons/icon_tab_jh_un@3x.png", title: "秀", isSelect: false, unreadNum: 0),
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_my_se@3x.png", unSelectIcon: "assets/icons/icon_tab_my_un@3x.png", title: "我的", isSelect: false, unreadNum: 0),
    ];
    return BaseTabBar(key: childTabViewKey, pages: pages, items: items);
  }
}

