import 'package:flutter/material.dart';

class AppPageWrapper extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  final double topPadding;
  final bool scrollable;
  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;

  const AppPageWrapper({
    super.key,
    required this.child,
    this.horizontalPadding = 0.08,
    this.topPadding = 30,
    this.scrollable = true,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom + 20;

    final content = Padding(
      padding: EdgeInsets.only(
        left: width * horizontalPadding,
        right: width * horizontalPadding,
        top: topPadding,
        bottom: bottomInset,
      ),
      child: child,
    );

    Widget body;
    if (scrollable) {
      body = Column(
        children: [
          Expanded(child: SingleChildScrollView(child: content)),
        ],
      );
    } else {
      body = Column(
        children: [
          Expanded(child: content),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: SafeArea(child: body),
    );
  }
}
