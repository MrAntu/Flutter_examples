import 'package:flutter/material.dart';

//class ToastView {
//  OverlayEntry overlayEntry;
//  OverlayState overlayState;
//  bool dismissed = false;
//
//  show() async {
//    overlayState.insert(overlayEntry);
//    await Future.delayed(Duration(milliseconds: 2000));
//    dismiss();
//  }
//
//  dismiss() {
//    if (dismissed) {
//      return;
//    }
//    dismissed = true;
//    overlayEntry.remove();
//  }
//}
//
//class Toast {
//  static ToastView toastView;
//
//  static show(BuildContext context, String msg) {
//    // 移除之前显示的view
//    toastView?.dismiss();
//    toastView = null;
//
//    var overlayState = Overlay.of(context);
//    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
//      return buildToastLayout(msg);
//    });
//
//    toastView = ToastView();
//    toastView.overlayState = overlayState;
//    toastView.overlayEntry = overlayEntry;
//    toastView.show();
//  }
//
//  static LayoutBuilder buildToastLayout(String msg) {
//    return LayoutBuilder(builder: (context, constaints) {
//      // 忽略任何的指针事件，包括点击
//      return IgnorePointer(
//        ignoring: true,
//        child: Container(
//          alignment: Alignment.bottomCenter,
//          child: Material(
//            color: Colors.white.withOpacity(0),
//            child: Container(
//              child: Text(
//                msg,
//                style: TextStyle(color: Colors.white),
//              ),
//              decoration: BoxDecoration(
//                  color: Colors.black.withOpacity(0.6),
//                  borderRadius: BorderRadius.all(Radius.circular(5))),
//              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//              margin: EdgeInsets.only(
//                bottom: constaints.biggest.height * 0.05,
////                  left: constaints.biggest.width * 0.2,
////                  right: constaints.biggest.width * 0.2
//              ),
//            ),
//          ),
//        ),
//      );
//    });
//  }
//}

class Toast {
  static ToastView preToast;

  static show(BuildContext context, String msg) {
    preToast?.dismiss();
    preToast = null;
    var overlayState = Overlay.of(context);
    var controllerShowAnim = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var controllerShowOffset = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    var controllerHide = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var opacityAnim1 =
        new Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);
    var controllerCurvedShowOffset = new CurvedAnimation(
        parent: controllerShowOffset, curve: _BounceOutCurve._());
    var offsetAnim =
        new Tween(begin: 30.0, end: 0.0).animate(controllerCurvedShowOffset);
    var opacityAnim2 = new Tween(begin: 1.0, end: 0.0).animate(controllerHide);

    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return ToastWidget(
        opacityAnim1: opacityAnim1,
        opacityAnim2: opacityAnim2,
        offsetAnim: offsetAnim,
        child: buildToastLayout(msg),
      );
    });
    var toastView = ToastView();
    toastView.overlayEntry = overlayEntry;
    toastView.controllerShowAnim = controllerShowAnim;
    toastView.controllerShowOffset = controllerShowOffset;
    toastView.controllerHide = controllerHide;
    toastView.overlayState = overlayState;
    preToast = toastView;
    toastView._show();
  }

  static LayoutBuilder buildToastLayout(String msg) {
    return LayoutBuilder(builder: (context, constaints) {
      // 忽略任何的指针事件，包括点击
      return IgnorePointer(
        ignoring: true,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Text(
                msg,
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.only(
                bottom: constaints.biggest.height * 0.05,
//                  left: constaints.biggest.width * 0.2,
//                  right: constaints.biggest.width * 0.2
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  AnimationController controllerShowAnim;
  AnimationController controllerShowOffset;
  AnimationController controllerHide;
  OverlayState overlayState;
  bool dismissed = false;

  _show() async {
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    await Future.delayed(Duration(milliseconds: 3500));
    this.dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    controllerHide.forward();
    await Future.delayed(Duration(milliseconds: 250));
    overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  ToastWidget(
      {this.child, this.offsetAnim, this.opacityAnim1, this.opacityAnim2});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnim1,
      child: child,
      builder: (context, child_to_build) {
        return Opacity(
          opacity: opacityAnim1.value,
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, offsetAnim.value),
                child: AnimatedBuilder(
                  animation: opacityAnim2,
                  builder: (context, _) {
                    return Opacity(
                      opacity: opacityAnim2.value,
                      child: child_to_build,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}
