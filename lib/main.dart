  import 'dart:math';

  import 'package:flutter/material.dart';
  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({
      Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: CardHiddenAnimationPage(),
      );
    }
  }
  class CardHiddenAnimationPage extends StatefulWidget {
    const CardHiddenAnimationPage({Key? key}) : super(key: key);

    @override
    State<CardHiddenAnimationPage> createState() =>
        CardHiddenAnimationPageState();
  }

  class CardHiddenAnimationPageState extends State<CardHiddenAnimationPage>
      with TickerProviderStateMixin {
    final cardSize = 150.0;

    late final holeSizeTween = Tween<double>(
      begin: 0,
      end: 1.5 * cardSize,
    );
    late final holeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    double get holeSize => holeSizeTween.evaluate(holeAnimationController);
    late final cardOffsetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    late final cardOffsetTween = Tween<double>(
      begin: 0,
      end: 2 * cardSize,
    ).chain(CurveTween(curve: Curves.easeInBack));
    late final cardRotationTween = Tween<double>(
      begin: 0,
      end: 0.5,
    ).chain(CurveTween(curve: Curves.easeInBack));
    late final cardElevationTween = Tween<double>(
      begin: 2,
      end: 20,
    );

    double get cardOffset =>
        cardOffsetTween.evaluate(cardOffsetAnimationController);
    double get cardRotation =>
        cardRotationTween.evaluate(cardOffsetAnimationController);
    double get cardElevation =>
        cardElevationTween.evaluate(cardOffsetAnimationController);

    @override
    void initState() {
      holeAnimationController.addListener(() => setState(() {}));
      cardOffsetAnimationController.addListener(() => setState(() {}));
      super.initState();
    }

    @override
    void dispose() {
      holeAnimationController.dispose();
      cardOffsetAnimationController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: AppBar(elevation: 500,
            backgroundColor: Colors.transparent,
            title:const Text("Press the FloatingActionButton to see the animation",style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                onPressed: () async {
                  holeAnimationController.forward();
                  await cardOffsetAnimationController.forward();
                  Future.delayed(const Duration(milliseconds: 200),
                          () => holeAnimationController.reverse());
                },
                child: const Text("Drop"),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                onPressed: () {
                  cardOffsetAnimationController.reverse();
                  holeAnimationController.reverse();
                },
                child: const Text("Add"),
              ),
            ],
          ),
          body: Center(
            child: SizedBox(
              height: cardSize * 1.25,
              width: double.infinity,
              child: ClipPath(
                clipper: BlackHoleClipper(),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: holeSize,
                      child: Image.asset(
                        'assets/hole.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(0, cardOffset),
                          child: Transform.rotate(
                            angle: cardRotation,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: HelloWorldCard(
                                size: cardSize,
                                elevation: cardElevation,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  class BlackHoleClipper extends CustomClipper<Path> {
    @override
    Path getClip(Size size) {
      final path = Path();
      path.moveTo(0, size.height / 2);
      path.arcTo(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        0,
        pi,
        true,
      );
      // Using -1000 guarantees the card won't be clipped at the top, regardless of its height
      path.lineTo(0, -1000);
      path.lineTo(size.width, -1000);
      path.close();
      return path;
    }

    @override
    bool shouldReclip(BlackHoleClipper oldClipper) => false;
  }

  class HelloWorldCard extends StatelessWidget {
    const HelloWorldCard({
      Key? key,
      required this.size,
      required this.elevation,
    }) : super(key: key);

    final double size;
    final double elevation;

    @override
    Widget build(BuildContext context) {
      return Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox.square(
          dimension: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: const Center(
              child: Text(
                'Black hole\nAnimation',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }
  }