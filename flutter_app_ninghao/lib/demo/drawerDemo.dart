import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("leo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("sdfsdf@qq.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("http://blogimages.jspang.com/blogtouxiang1.jpg"),
            ),
            decoration: BoxDecoration(
                color:  Colors.yellow[400],
                image: DecorationImage(
                    image: NetworkImage("http://newimg.jspang.com/react_blog_demo.jpg"),
                    fit: BoxFit.cover, //设置图片模式，全覆盖
                    //设置颜色滤镜
                    colorFilter: ColorFilter.mode(
                        Colors.yellow[400].withOpacity(0.6),
                        BlendMode.hardLight
                    )
                )
            ),
          ),
          ListTile(
            title: Text("message", textAlign: TextAlign.right),
            trailing: Icon(Icons.message, size: 22,),
          ),
          Divider(),
          ListTile(
            title: Text("notifications", textAlign: TextAlign.right),
            trailing: Icon(Icons.not_interested, size: 22,),
          ),
          Divider(),
          ListTile(
            title: Text("settings", textAlign: TextAlign.right),
            trailing: Icon(Icons.settings, size: 22,),
          ),
          Divider(),

        ],
      ),
    );
  }
}




