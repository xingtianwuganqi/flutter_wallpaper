import 'package:flutter/material.dart';
import 'package:flutter_wallpaper/home_page/edit_page.dart';

import 'home_page_model.dart';

class HomePageListPage extends StatefulWidget {
  const HomePageListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageListPageState();
  }
}

class HomePageListPageState extends State<HomePageListPage> {
  
  List<HomePageListModel> homeListModels = [
    HomePageListModel(),
    HomePageListModel(isAdd: true)
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0
      ),itemCount: homeListModels.length,
          itemBuilder: (context, index) {
          var item = homeListModels[index];
          if (item.isAdd == true) {
            return addItem();
          }else{
            return Container();
          }
        }
      )
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
}