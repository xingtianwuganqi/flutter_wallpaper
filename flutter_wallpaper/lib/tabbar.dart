import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/C_ShowList/ShowPageListPage.dart';
import 'package:flutter_wallpaper/D_Mine/MyPage.dart';
import 'B_HomePage/HomePageListPage.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeTabStatus();
  }
}

class HomeTabStatus extends State<HomeTab> {
  int _selectedIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages.add(HomePageListPage());
    pages.add(ShowPageListPage());
    pages.add(MyPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_sharp) ,label: "首页"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_sharp) ,label: "发现"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_sharp) ,label: "我的"),
      ],
      currentIndex: _selectedIndex,
      // fixedColor: ColorsUtil.fromEnmu(ColorEnum.system),
      type: BottomNavigationBarType.fixed,
      // unselectedItemColor: ColorsUtil.hexColor(0x707070),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 25,
      elevation: 2.0,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}