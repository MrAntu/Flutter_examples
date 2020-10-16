import 'package:flutter/material.dart';
import 'dart:async';
class StreamDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamDemo"),
      ),
      body: StreamHome(),
    );
  }
}

class StreamHome extends StatefulWidget {
  @override
  _StreamHomeState createState() => _StreamHomeState();
}

class _StreamHomeState extends State<StreamHome> {

  StreamSubscription _streamSubscription;
  StreamController<String> _streamDemo;
  StreamSink _sink;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("create stream");
//    Stream<String> _streamDemo = Stream.fromFuture(fetchData());
    //能多次订阅

    _streamDemo = StreamController<String>.broadcast();
    _sink = _streamDemo.sink;


    print("start listen");
    _streamSubscription = _streamDemo.stream.listen(onData, onError: onError, onDone: onDone);

    _streamDemo.stream.listen(onData2, onError: onError, onDone: onDone);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamDemo.close();
    super.dispose();
  }


  void onDone() {
    print("done");
  }

  void onError(error) {
    print("$error");
  }

  void onData(String data) {
    print("$data");
  }

  void onData2(String data) {
    print("data2:  $data");
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 5));
//    throw "some happend";
    return "hello---";
  }

  void pause() {
    print("pause");
    _streamSubscription.pause();
  }

  void resume() {
    print("resume");
    _streamSubscription.resume();
  }

  void cancel() {
    print("cancel");
    _streamSubscription.cancel();
  }

  void addData() async {
    print("add data");
    fetchData().then((value) {
      print(value);
      _sink.add(value);
    }).catchError((error) {
      _sink.addError(error);
//      print(error);
    });
//    String data = await fetchData();
//    _streamDemo.add(data);
//    _sink.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: _streamDemo.stream,
            initialData: "....",
            builder: (contenxt, snapshot) {
              return Text("${snapshot.data}");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              FlatButton(
                onPressed: addData,
                child: Text("add data"),
              ),
              FlatButton(
                onPressed: pause,
                child: Text("puase"),
              ),
              FlatButton(
                onPressed: resume,
                child: Text("resume"),
              ),
              FlatButton(
                onPressed: cancel,
                child: Text("cancel"),
              ),
            ],
          ),
        ],
      )
    );
  }
}

