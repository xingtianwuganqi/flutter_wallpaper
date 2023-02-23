
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //   key: _scaffoldKey,
    //   appBar: AppBar(
    //     title: Text("编辑"),
    //     actions: [
    //       IconButton(onPressed: (){
    //         _scaffoldKey.currentState?.openEndDrawer();
    //       }, icon: const Icon(Icons.settings))
    //     ],
    //   ),
    //   endDrawer:
    //       const Drawer(),
    //   // SizedBox(
    //   //   width: MediaQuery.of(context).size.width * 0.7,
    //   //   child: const Drawer(
    //   //     child: Text("测试"),
    //   //   ),
    //   // ),
    //   body: Center(
    //     child: IconButton(onPressed: (){
    //
    //     }, icon: const Icon(Icons.settings)),
    //   ) ,
    // );

    var appBar = AppBar(
      // title: Text("编辑",style: TextStyle(color: appBarAlpha >= 1 ? Colors.black : Colors.white,fontSize: 18),),
      // backgroundColor: Colors.white.withOpacity(appBarAlpha),

      elevation: 0,

      leading:
      // appBarAlpha >= 1 ?
      IconButton(onPressed: (){
        Navigator.pop(context);
      },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
      // :IconButton(onPressed: (){
      //   Navigator.pop(context);
      // }, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.settings)),
      ],
    );
    return Stack(
      children: [
        MediaQuery.removePadding(
        removeTop: true,
        context: context,
        // 监听列表的滚动
        child: Container(color: Colors.blue)

        // NotificationListener(
        //   )

        ),
        Container(
          height: appBar.preferredSize.height + 40,
          color: Colors.white.withOpacity(appBarAlpha),
          child: appBar,
        ),
      ],
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}