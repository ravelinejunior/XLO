import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/stores/page_store.dart';

class CreateAdButton extends StatefulWidget {
  final ScrollController controller;
  const CreateAdButton(this.controller);
  @override
  _CreateAdButtonState createState() => _CreateAdButtonState();
}

class _CreateAdButtonState extends State<CreateAdButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    buttonAnimation = Tween<double>(begin: 0, end: 85).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.6),
      ),
    );
    widget.controller.addListener(scrollChanged);
  }

  void scrollChanged() {
    final contextScroll = widget.controller.position;
    if (contextScroll.userScrollDirection == ScrollDirection.forward) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (_, __) {
        return FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(bottom: buttonAnimation.value),
            child: RaisedButton(
              splashColor: Colors.deepOrange,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                GetIt.I<PageStore>().setPage(1);
              },
              color: Colors.orange,
              child: Row(
                children: [
                  Icon(Icons.camera_alt, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Anunciar Agora',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
