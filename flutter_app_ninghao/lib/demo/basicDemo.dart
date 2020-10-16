import 'package:flutter/material.dart';


class BasicDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ContainerDemo();
  }
}


class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(Icons.pool, size: 32, color: Colors.white,),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(8),
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Color.fromRGBO(3, 54, 255, 1),
            border: Border.all(
              color: Colors.indigoAccent[100],
              width:  3,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: Colors.black,
                blurRadius: 8,
                spreadRadius: -1
              )
            ]
          ),
        )
      ],
    );
  }
}


// Text组件
class TextDemo extends StatelessWidget {
  final TextStyle _style = TextStyle(
      fontSize: 16
  );
  final String _title = "将进酒";
  final String _autor = "李白";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "《$_title》-- $_autor。君不见，黄河之水天上来⑵，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪⑶。人生得意须尽欢⑷，莫使金樽空对月。天生我才必有用，千金散尽还复来。烹羊宰牛且为乐，会须一饮三百杯⑸。岑夫子，丹丘生⑹，将进酒，杯莫停⑺。与君歌一曲⑻，请君为我倾耳听⑼。钟鼓馔玉不足贵⑽，但愿长醉不复醒⑾。古来圣贤皆寂寞，惟有饮者留其名。陈王昔时宴平乐，斗酒十千恣欢谑⑿。主人何为言少钱⒀，径须沽取对君酌⒁。五花马⒂，千金裘，呼儿将出换美酒，与尔同销万古愁⒃。",
          textAlign: TextAlign.left,
          style: _style,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),

        //设置富文本
        RichText(
          text: TextSpan(
              text: "helloworld",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 34,
                  fontWeight: FontWeight.w100
              ),
              children: [
                TextSpan(
                    text: ".com",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey
                    )
                )
              ]
          ),
        )
      ],
    );
  }
}
