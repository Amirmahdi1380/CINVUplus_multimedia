import 'dart:async';

import 'package:connectplus/config/theme.dart';
import 'package:connectplus/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void didPush() {
    print('HomePage: Called didPush');
    super.didPush();
  }

  @override
  void didPop() {
    print('HomePage: Called didPop');
    super.didPop();
  }

  @override
  void didPopNext() {
    print('HomePage: Called didPopNext');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('HomePage: Called didPushNext');
    super.didPushNext();
  }

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeTransition(
                          opacity: animation!,
                          child: const Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: smallDistance),
                        ),
                        SvgPicture.asset(
                          'assets/images/cinvu-logo.svg',
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(
                          height: smallDistance,
                        ),
                        Column(
                          children: const [
                            Text(
                              'CINVU Plus',
                              style: TextStyle(
                                color: Color(0xff313F6B),
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'www.cinvu.net',
                              style: TextStyle(
                                color: Color(0xff313F6B),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 5.3,
                          backgroundColor: Color(0xff313F6B),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: largeDistance),
                        ),
                        const Text(
                          "Loading...",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xff313F6B),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}