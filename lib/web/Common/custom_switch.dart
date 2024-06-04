import 'package:flutter/material.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/theme/theme_helper.dart';


class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward(from: 0.0); // Clockwise animation on switch on
      } else {
        _controller.reverse(from: 1.0); // Counterclockwise animation on switch off
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 58.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: widget.value ? appTheme.black : appTheme.themeColor,
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: widget.value ? 3.5 : 4,
              bottom: widget.value ? 3.5 : 4,
              left: widget.value ? 28.0 : 2.5,
              right: widget.value ? 2.5 : 28.0,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: widget.value
                        ? _animation.value * 3.1415926535897932
                        : (1 - _animation.value) * 3.1415926535897932,
                    child: child,
                  );
                },
                child: widget.value
                    ? Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Image.asset(
                   AssetRes.moonIcon,
                    key: UniqueKey(),
                    height: 21,
                    width: 21,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Image.asset(
                    AssetRes.sunIcon,
                    key: UniqueKey(),
                    height: 21,
                    width: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
