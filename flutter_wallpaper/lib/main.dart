import 'package:flutter/material.dart';
import 'package:flutter_basic/base_model.dart';
import 'package:flutter_basic/base_tabbar.dart';
import 'package:flutter_basic/base_tools.dart';
import 'package:flutter_wallpaper/home_page/home_page_list.dart';
import 'package:flutter_wallpaper/mine/my_page.dart';
import 'package:flutter_wallpaper/show_list/show_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


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
    setAppIdentifier(AppIdEnum.plan);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.indigo,
            foregroundColor: Colors.white,
            elevation: 0.2
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
        primaryColor: Colors.white,
        primarySwatch: Colors.indigo, // 刷新控件的颜色
        // 使用 Scaffold 构件的页面，统一设置背景颜色
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
        highlightColor: Colors.transparent,
      ),
      home: const HomePageListPage(),
      builder: EasyLoading.init(),
    );
  }

  Widget createTabBar() {
    List<Widget> pages = [const HomePageListPage(),const ShowPageListPage(),const MyPage()];
    List<BottomNavigationModel> items = [
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_home_sele@3x.png", unSelectIcon: "assets/icons/icon_tab_home_un@3x.png", title: "首页", isSelect: false, unreadNum: 0),
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_jh_sele@3x.png", unSelectIcon: "assets/icons/icon_tab_jh_un@3x.png", title: "秀", isSelect: false, unreadNum: 0),
      BottomNavigationModel(selectIcon: "assets/icons/icon_tab_my_sele@3x.png", unSelectIcon: "assets/icons/icon_tab_my_un@3x.png", title: "我的", isSelect: false, unreadNum: 0),
    ];
    return BaseTabBar(key: childTabViewKey, pages: pages, items: items);
  }
}

