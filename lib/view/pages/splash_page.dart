import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wdm/common/constant.dart';
import 'package:flutter_wdm/utils/object_util.dart';
import 'package:flutter_wdm/utils/sp_util.dart';
import 'package:flutter_wdm/utils/timer_util.dart';
import 'package:flutter_wdm/utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<String> _guideImgList = [
    Utils.getImgPath('guide1', format: 'jpg'),
    Utils.getImgPath('guide2', format: 'jpg'),
    Utils.getImgPath('guide3', format: 'jpg'),
    Utils.getImgPath('guide4'),
  ];

  List<Widget> _bannerList = new List();
  int _count = 3;
  TimerUtil _timerUtil;
  int _isFirstLogin = 0;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    if (SpUtil.getBool(Constant.first_login, defValue: true)) {
      SpUtil.putBool(Constant.first_login, false);
      _initGuideBanner();
      setState(() {
        _isFirstLogin = 0;
      });
    } else {
      _doCountDown();
      setState(() {
        _isFirstLogin = 1;
      });
    }
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      children: <Widget>[
        Offstage(
            offstage: !(_isFirstLogin == 0),
            child: ObjectUtil.isEmpty(_bannerList)
                ? Container()
                : Swiper(
                    children: _bannerList,
                    autoStart: false,
                    circular: true,
                    indicator: CircleSwiperIndicator(
                      radius: 4.0,
                      padding: EdgeInsets.only(bottom: 30.0),
                      itemColor: Colors.black26,
                    ),
                  )),
        Offstage(
          offstage: !(_isFirstLogin == 1),
          child: Container(
              child: Stack(children: <Widget>[
            Image.asset(
              Utils.getImgPath('splash_bg', format: 'jpeg'),
              width: double.infinity,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            Positioned(
                right: 20,
                bottom: 20,
                child: Container(
                    width: 70,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/home");
                      },
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "跳过$_count",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0x66000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  width: 0.33, color: Color(0xffe5e5e5)))),
                    )))
          ])),
        )
      ],
    ));
  }

  _initGuideBanner() {
    for (int i = 0, length = _guideImgList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(children: <Widget>[
          Image.asset(_guideImgList[i]),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: 200,
                margin: EdgeInsets.only(bottom: 160.0),
                child: RaisedButton(
                  shape: CircleBorder(),
                  child: Text(
                    '立即体验',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(6, 3),
                              blurRadius: 10)
                        ]),
                  ),
                  onPressed: () {
                    log("message");
                  },
                  elevation: 2.0,
                  highlightElevation: 2.0,
                  disabledElevation: 2.0,
                  color: Colors.blue,
                ),
              )),
        ]));
      } else {
        _bannerList.add(new Image.asset(
          _guideImgList[i],
           fit: BoxFit.fill,
           width: double.infinity,
           height: double.infinity,
        ));
      }
    }
  }
}
