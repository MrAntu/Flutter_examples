import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../providers/find_detail_provider.dart';
import '../../exports.dart';
import 'views/find_detail_content.dart';
import 'views/comment_item.dart';
import 'views/find_bottom_tool.dart';
import 'package:get/get.dart';
import 'detail_controller.dart';
import 'base_controller.dart';

class FindDetailPage extends StatefulWidget {
  final int messageId;

  const FindDetailPage({Key key, this.messageId}) : super(key: key);

  @override
  _FindDetailPageState createState() => _FindDetailPageState();
}

class _FindDetailPageState extends State<FindDetailPage> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.lazyPut(() => DetailController());
  }

  @override
  void dispose() {
    _editingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     resizeToAvoidBottomInset: false, // 防止底部被键盘弹起
    //     appBar: AppBar(
    //       title: Text('动态详情'),
    //     ),
    //     body: GetBuilder<DetailController>(
    //       init: DetailController(),
    //       didChangeDependencies: (_) {
    //         Get.find<DetailController>()
    //             .refreshData(widget.messageId, first: true);
    //       },
    //       builder: (controller) {
    //         // 加载中
    //         if (controller.viewState == BaseViewState.busy) {
    //           // 默认
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //
    //         // 加载错误
    //         if (controller.viewState == BaseViewState.error) {
    //           Toast.showError(controller.viewStateError.toString());
    //           // 默认
    //           return EmptyWidget(showReload: false);
    //         }
    //         return Container(
    //           child: Text('加载成功'),
    //         );
    //       },
    //     ));
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止底部被键盘弹起
      appBar: AppBar(
        title: Text('动态详情'),
      ),
      body: ConsumeProviderWidget<FindDetailProvider>(
        model: FindDetailProvider(),
        onReady: (viewModel) {
//          viewModel.requestFindDetail(messageId);
          viewModel.refreshData(widget.messageId, first: true);
        },
        onLoadingWidget: (ctx, model) {
          Toast.showLoading();
          return Container();
        },
        builder: (ctx, viewModel, child) {
          // if (viewModel.viewState == ViewState.busy) {
          //   Toast.showLoading();
          //   return Container();
          // }
          Toast.dismiss();
          if (viewModel.viewState == ViewState.error) {
            Toast.showError(viewModel.viewStateError.toString());
          }
          return Container(
            child: Column(
              children: [
                Expanded(child: _renderListView(viewModel)),
                _renderBottom(viewModel, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _renderBottom(FindDetailProvider vModel, BuildContext context) {
    if (vModel.detailModel == null) {
      return Container();
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom, left: 16, right: 30),
      child: FindBottomTool(
        focusNode: _focusNode,
        controller: _editingController,
        submitAction: (text) {
          print(text);
        },
        agreeState: true,
        agreeCount: '10',
        collectionCount: '20',
        actionCallback: (type) {
          print(type);
        },
      ),
    );
  }

  Widget _renderListView(FindDetailProvider vModel) {
    return SmartRefresher(
      controller: vModel.refreshController,
      enablePullUp: true,
      onRefresh: () {
        vModel.refreshData(widget.messageId);
      },
      onLoading: () {
        vModel.loadMoreData(widget.messageId);
      },
      child: CustomScrollView(
        slivers: [
          _renderDetail(vModel),
          _renderCommentList(vModel),
        ],
      ),
    );
  }

  Widget _renderCommentList(FindDetailProvider vModel) {
    if (vModel.commentList.length == 0) {
      return SliverToBoxAdapter(
        child: EmptyWidget(showReload: false),
      );
    }
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (ctx, index) {
        return CommentItem(
          model: vModel.commentList[index],
          userId: vModel.detailModel.userId,
          key: ValueKey(index),
          actionCallBack: (type) {
//            _currentComment = _commentList[index];
            if (type == FindActionType.agree) {
//              requestCommentAgree(model: _commentList[index]);
            } else if (type == FindActionType.commentSelect) {
//              final model = _commentList[index];
//              LoginInfo loginInfo = SharedStorage.loginInfo;
              if (vModel.detailModel.userId == CommonTool.loginInfo.userId) {
//                showCommentSelect();
              } else {
//                showCommentItem((text) {
//                  replyComment(text);
//                });
              }
            } else {
//              handleItemAction(type);
            }
          },
        );
      },
      childCount: vModel.commentList.length,
    ));
  }

  Widget _renderDetail(FindDetailProvider vModel) {
    if (ObjectUtil.isEmpty(vModel.detailModel)) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverToBoxAdapter(
        child: FindDetailContent(vModel.detailModel),
      ),
    );
  }
}
