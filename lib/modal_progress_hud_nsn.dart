library modal_progress_hud_nsn;

import "modal_progress_hud_nsn_platform_interface.dart";
import "package:flutter/material.dart";
import "dart:ui";

class ModalProgressHudNsn {
  Future<String?> getPlatformVersion() {
    return ModalProgressHudNsnPlatform.instance.getPlatformVersion();
  }
}

///
/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// HUD=Heads Up Display
///
class ModalProgressHUD extends StatelessWidget {

  /// A required bool to check dark mode or not
  final bool isDarkMode;

  /// A required [bool]to toggle the loading animation.
  final bool inAsyncCall;

  /// A [double] value which states how opaque the loading overlay should be, defaults to 0.3
  final double opacity;

  /// A [Color] object which is assigned to the loading barrier, defaults to grey
  final Color color;

  /// An [Offset] object which is applied to the [progressIndicator] when specified.
  final Offset? offset;

  /// A [bool] value which sets the `loading screen can be dismissible by tapping on the loading screen` rule.
  final bool dismissible;

  /// A [Widget] which should be the the widget to be shown behind the loading barrier.
  final Widget child;

  /// A [double] value specifying the amount of background blur when progress hud is active.
  final double blur;

  const ModalProgressHUD({
    Key? key,
    required this.inAsyncCall,
    this.isDarkMode = false,
    this.opacity = 0.3,
    this.color = const Color.fromRGBO(51, 51, 51, 1),
    this.offset,
    this.dismissible = false,
    required this.child,
    this.blur = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Center(
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: isDarkMode ? Color.fromRGBO(1, 18, 28, 1) : Colors.white),
              color: isDarkMode ? Color.fromRGBO(1, 18, 28, 1) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isDarkMode ? CircularProgressIndicator(color: Color.fromRGBO(237, 243, 247, 1)):CircularProgressIndicator(color: Color.fromRGBO(4, 75, 127, 1)),
                SizedBox(width: 16),
                Text("Loading...",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        decoration: TextDecoration.none))
              ]),
        ),
      );
    } else {
      layOutProgressIndicator = Positioned(
        left: offset!.dx,
        top: offset!.dy,
        child:  Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: isDarkMode ? Color.fromRGBO(1, 18, 28, 1) : Colors.white),
              color: isDarkMode ? Color.fromRGBO(1, 18, 28, 1) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isDarkMode ? CircularProgressIndicator(color: Color.fromRGBO(237, 243, 247, 1)):CircularProgressIndicator(color: Color.fromRGBO(4, 75, 127, 1)),
                SizedBox(width: 16),
                Text("Loading...",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        decoration: TextDecoration.none))
              ]),
        ),
      );
    }

    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: dismissible, color: color),
          ),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
