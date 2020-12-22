import 'package:flutter/material.dart';
import '../../models/grass_model.dart';
import '../request/request.dart';
import '../../exports.dart';

typedef GrassCallBack = void Function(GrassModel grassModel);

class GrassDetailPage extends StatelessWidget {
  final int trialId;
  final GrassCallBack callback;
  GrassDetailPage({Key key, this.trialId, this.callback}) : super(key: key);

  Future<GrassModel> loadDetail() {
    return Request.loadGrassDetail(trialId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('水电费'),
        actions: [
          GestureDetector(
            child: Icon(Icons.share),
            onTap: () {},
          ),
          SizedBox(width: 16)
        ],
      ),
      body: FutureCustomBuilder<GrassModel>(
        future: loadDetail(),
        builder: (ctx, data) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _renderUserInfo(data),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _renderUserInfo(GrassModel model) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ExtendCachedNetworkImage(
                imageUrl: model.headImg ?? "",
                width: 40,
                height: 40,
                corner: 20,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.nickname ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    model.createTime ?? "",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          _renderFocusButton(model),
        ],
      ),
    );
  }

  Widget _renderFocusButton(GrassModel model) {
    if (model.isSelf) {
      return Container();
    }
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            color: Color(0xFFFFB74D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFFFFB74D), width: 0.5)),
        child: Text(
          '+关注',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
