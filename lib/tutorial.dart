library tutorial;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorial/services/tutorial_service.dart';

import 'model/tutorial_item.dart';
export 'model/tutorial_item.dart';
export 'services/tutorial_service.dart';

class Tutorial extends StatefulWidget {
  /// [builder] is the widget that will be shown in the tutorial
  final Widget Function(
      BuildContext context, GlobalKey<State<StatefulWidget>> key) builder;

  /// [order] is the order of the tutorial
  final int order;

  /// [category] is the category of the tutorial
  final String category;

  /// [instruction] is the instruction of the tutorial
  final String instruction;

  const Tutorial({
    super.key,
    required this.builder,
    required this.order,
    required this.instruction,
    required this.category,
  });

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  late GlobalKey globalKey;
  late Widget child;

  @override
  void initState() {
    globalKey = GlobalObjectKey('${widget.instruction}-${widget.order}');
    final notFound = TutorialService.tutorialItemList
        .where((element) => element.key == globalKey)
        .isEmpty;
    if (notFound) {
      TutorialService.tutorialItemList.add(TutorialItem(
        key: globalKey!,
        order: widget.order,
        instruction: widget.instruction,
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, globalKey);
  }
}
