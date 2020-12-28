import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../exports.dart';
import '../../providers/find_focus_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'views/find_list_item.dart';

class FindFocusPage extends StatefulWidget {
  const FindFocusPage({Key key}) : super(key: key);

  @override
  _FindFocusPageState createState() => _FindFocusPageState();
}

class _FindFocusPageState extends State<FindFocusPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ConsumeProviderWidget<FindFocusProvider>(
        model: FindFocusProvider(),
        onReady: (model) {
          model.refreshData(first: true);
        },
        builder: (ctx, model, child) {
          // if (model.viewState == ViewState.busy) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (model.viewState == ViewState.error) {
          //   Toast.showError(model.viewStateError.toString());
          // }
          return _renderContent(model);
        });
  }

  Widget _renderContent(FindFocusProvider model) {
    return SmartRefresher(
      controller: model.refreshController,
      enablePullUp: CommonTool.hasLogin(),
      onRefresh: () {
        if (CommonTool.hasLogin()) {
          model.refreshData();
        } else {
          model.refreshController.refreshCompleted();
        }
      },
      onLoading: () {
        model.loadMoreData();
      },
      child: CustomScrollView(
        slivers: [
          _renderFocusHeader(model),
          _renderPostList(model),
        ],
      ),
    );
  }

  Widget _renderPostList(FindFocusProvider model) {
    if (model.viewState == ViewState.empty) {
      return SliverToBoxAdapter(
        child: EmptyWidget(showReload: false),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            final item = model.focusPostList[index];
            return FindListItem(model: item);
          },
          childCount: model.focusPostList.length,
        ),
      ),
    );
  }

  Widget _renderFocusHeader(FindFocusProvider model) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _renderFocusTitle(model),
          _renderFocusPeopleList(model),
        ],
      ),
    );
  }

  Widget _renderFocusPeopleList(FindFocusProvider model) {
    if (model.recomFocusList.isEmpty) {
      return Container();
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: model.recomFocusList
              .map((e) => _renderFocusPeopleListItem(e))
              .toList(),
        ),
      ),
    );
  }

  Widget _renderFocusPeopleListItem(FocusModel item) {
    final itemWith = (ScreenUtil().screenWidth - (32 + 20)) / 3;
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(minWidth: itemWith),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white),
      child: Column(
        children: [
          ExtendCachedNetworkImage(
            imageUrl: item.headImg,
            width: 50,
            height: 50,
            corner: 25,
          ),
          SizedBox(width: 4),
          Container(
            height: 24,
            alignment: Alignment.center,
            child: Text(
              item.nickname,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 24,
            alignment: Alignment.center,
            child: Text(
              item.petBreed ?? '',
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            child: Text(
              '已有${item.relationNum}人关注',
              style: TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 60,
            height: 20,
            child: RaisedButton(
              onPressed: () {},
//            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              textColor: Colors.black,
              elevation: 1,
              color: Colors.yellow,
              shape: StadiumBorder(),
              child: Text(
                '+关注',
                style: TextStyle(fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderFocusTitle(FindFocusProvider model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '你可能想认识他们~',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              '换一批',
              style: TextStyle(fontSize: 13),
            ),
            textColor: Colors.black,
            color: Colors.yellow,
            shape: StadiumBorder(),
            elevation: 1,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
