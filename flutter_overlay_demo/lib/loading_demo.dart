import 'package:flutter/material.dart';
import 'loading.dart';

// class LoadingDemo extends StatelessWidget {
//   const LoadingDemo({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('loading'),
//       ),
//       body: Loading(
//         isLoading: true,
//         child: Center(
//           child: Container(
//             color: Colors.green,
//             height: 200,
//             width: 200,
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoadingDemo extends StatefulWidget {
  LoadingDemo({Key key}) : super(key: key);

  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class _LoadingDemoState extends State<LoadingDemo> {
  var _isShow = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      setState(() {
        _isShow = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('loading'),
      ),
      body: Loading(
        isLoading: _isShow,
        child: Center(
          child: Container(
            color: Colors.green,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
