import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LoginButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginButtonState();
  }
}

class LoginButtonState extends State<LoginButton>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Tween<double> tween;
  int current = 0;
  bool isStopAnimation = true;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: 50), vsync: this);
    tween = new MIntTween(0.0, 1.0);
    animation = tween.animate(controller)
      ..addStatusListener((state) {
        //当动画结束时执行动画反转
        if (state == AnimationStatus.completed) {
          //当动画在开始处停止再次从头开始执行动画
//          controller.forward(from:0.0);
          print("动画完成");
          if (isStopAnimation) {

          } else {

          }
          controller.forward(from:0.0);
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
          print("动画停止");
        } else if (state == AnimationStatus.forward) {
          print("动画执行");
        } else if (state == AnimationStatus.reverse) {
          print("动画反向");
        }
        if(!isStopAnimation) {
          setState(() {
            current++;
          });
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    print(controller.value.toString());
//    print(animation.value.toString());
    return new GestureDetector(
      onTap: () {
        isStopAnimation = !isStopAnimation;
        if (!isStopAnimation) {
          startAnimation();
        } else {
          stopAnimation();
        }
        setState(() {});
      },
      child: new Container(
        width: 200,
        height: 50,
        child: new CustomPaint(
          painter: new LoginPainter(current % 4, isStopAnimation),
          child: new Center(
            child: new Text(
              isStopAnimation ? "登录" : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void startAnimation() {
    isStopAnimation = false;
    controller.forward();
  }

  void stopAnimation() {
    isStopAnimation = true;
  }
}

class LoginPainter extends CustomPainter {
  /**
   * 个数是4
   * 变长为5
   * 间距为10
   */
  List<Rect> rects = new List()
    ..add(new Rect.fromLTRB(75, 22.5, 80, 27.5))
    ..add(new Rect.fromLTRB(90, 22.5, 95, 27.5))
    ..add(new Rect.fromLTRB(105, 22.5, 110, 27.5))
    ..add(new Rect.fromLTRB(120, 22.5, 125, 27.5));
  Paint rectPaint = new Paint()
    ..blendMode = (BlendMode.srcOver)
    ..color = Colors.lightBlue
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  Paint rectPaintNormal = new Paint()
    ..blendMode = BlendMode.srcOver
    ..color = Colors.red
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  Paint rectPaintSlect = new Paint()
    ..blendMode = BlendMode.srcOver
    ..color = Colors.white
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  final int currentValue;

  LoginPainter(this.currentValue, this.isStopAnimation);

  final bool isStopAnimation;

  @override
  void paint(Canvas canvas, Size size) {
//    canvas.drawColor(Colors.red, BlendMode.srcOver);
    //根据上面的矩形,构建一个圆角矩形
    RRect rrect = RRect.fromRectAndRadius(
        new Rect.fromLTRB(0, 0, 200, 50), Radius.circular(5.0));
    canvas.drawRRect(rrect, rectPaint);
    if (!isStopAnimation) {
      for(var i =0; i< 4;i++) {
        var rect = rects[i];
        canvas.drawRect(rect, rectPaintNormal);

        if ((3-i).abs() == currentValue) {
          canvas.drawRect(rect, rectPaintSlect);
        } else {
          canvas.drawRect(rect, rectPaintNormal);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class MIntTween extends Tween<double> {
  MIntTween(begin, end) {
    super.begin = begin;
    super.end = end;
  }

  @override
  double lerp(double t) {
    return super.lerp(t);
  }
}
