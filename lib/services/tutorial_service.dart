import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/tutorial_item.dart';

class TutorialService {
  static List<TutorialItem> tutorialItemList = [];
  static EdgeInsets? _padding;
  static Color? _overlayColor;
  static bool _showButton = false;

  static init({EdgeInsets? padding, Color? overlayColor, bool? showButton}) {
    _padding = padding;
    _overlayColor = overlayColor;
    _showButton = showButton ?? false;
  }

  static startTutorial(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final halfScreen = screenHeight / 2;
    Future.microtask(() {
      tutorialItemList.sort(
            (prev, next) {
          return prev.order.compareTo(next.order);
        },
      );

      OverlayEntry? overlayEntry;
      overlayEntry = OverlayEntry(builder: (context) {
        final padding = _padding ?? const EdgeInsets.all(4);
        var index = 0;
        var tutorialItem = tutorialItemList[index];
        final renderBox =
        tutorialItem.key.currentContext?.findRenderObject() as RenderBox?;
        double dx = renderBox
            ?.localToGlobal(Offset.zero)
            .dx ?? 0;
        double dy = renderBox
            ?.localToGlobal(Offset.zero)
            .dy ?? 0;
        double width = renderBox?.size.width ?? 0;
        double height = renderBox?.size.height ?? 0;

        return StatefulBuilder(builder: (context, setState) {
          final isBottomScreen = dy > halfScreen;
          nextTutorial() {
            if (index == tutorialItemList.length - 1) {
              overlayEntry?.remove();
              tutorialItemList.clear();
              return;
            }
            index++;
            setState(() {
              tutorialItem = tutorialItemList[index];
              final renderBox = tutorialItem.key.currentContext
                  ?.findRenderObject() as RenderBox?;
              dx = renderBox
                  ?.localToGlobal(Offset.zero)
                  .dx ?? 0;
              dy = renderBox
                  ?.localToGlobal(Offset.zero)
                  .dy ?? 0;
              width = renderBox?.size.width ?? 0;
              height = renderBox?.size.height ?? 0;
            });
          }

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                nextTutorial();
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      clipper: _TutorialClipper(
                        width: width + padding.left + padding.right,
                        height: height + padding.top + padding.bottom,
                        top: dy - padding.top,
                        left: dx - padding.bottom,
                      ),
                      child: ColoredBox(
                        color: _overlayColor ?? Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: dy - (isBottomScreen ? 32 : -(height + 32)),
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 200),
                    child: Center(
                      child: Text(
                        tutorialItem.instruction,
                        style: tutorialItem.style ??
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: isBottomScreen ? 60 : null,
                    bottom: isBottomScreen ? null : 60,
                    left: 16,
                    right: 16,
                    duration: const Duration(milliseconds: 200),
                    child: Visibility(
                      visible: _showButton,
                      child: ElevatedButton(
                        onPressed: () {
                          nextTutorial();
                        },
                        child: const Text('Next'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });

      Overlay.of(context)?.insert(overlayEntry);
    });
  }
}

class _TutorialClipper extends CustomClipper<Path> {
  final double width;
  final double height;
  final double left;
  final double top;

  _TutorialClipper({
    required this.width,
    required this.height,
    required this.left,
    required this.top,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTWH(left, top, width, height),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    ));
    path.moveTo(left, top);
    path.lineTo(left, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
