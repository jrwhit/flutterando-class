import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class MyPageIndicatorContainer extends StatefulWidget {
  final Widget child;

  final int length;

  final EdgeInsets padding;

  final IndicatorAlign align;

  final IndicatorShape shape;

  final double pageViewHeight;

  final Color indicatorColor;

  final Color indicatorSelectorColor;

  final double indicatorSpace;

  const MyPageIndicatorContainer({
    Key key,
    @required this.child,
    @required this.length,
    this.padding = const EdgeInsets.only(bottom: 10.0, top: 10.0),
    this.align = IndicatorAlign.bottom,
    this.indicatorColor = Colors.white,
    this.indicatorSelectorColor = Colors.grey,
    this.indicatorSpace = 8.0,
    this.shape = IndicatorShape.defaultCircle,
    this.pageViewHeight,
  }) : super(key: key);

  @override
  PageContainerState createState() => PageContainerState();
}

class PageContainerState extends State<MyPageIndicatorContainer> {
  double currentPage;

  @override
  Widget build(BuildContext context) {
    if (widget.child is! PageView) {
      return widget.child;
    }

    double height = widget.shape.height;

    final initPage = pageView?.controller?.initialPage ?? 0.0;

    final currentPage = this.currentPage ?? initPage.toDouble();

    Widget indicator = PageIndicator(
      length: widget.length,
      color: widget.indicatorColor,
      selectedColor: widget.indicatorSelectorColor,
      indicatorSpace: widget.indicatorSpace,
      indicatorShape: widget.shape,
      align: widget.align,
      reverse: pageView.reverse,
      currentPage: currentPage,
      initialPage: initPage.toDouble(),
    );

    var align = widget.align;

    if (align == IndicatorAlign.bottom) {
      indicator = Positioned(
        left: 0.0,
        right: 180,
        bottom: 0.0,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.padding.left,
            right: widget.padding.right,
          ),
          child: indicator,
        ),
      );
    } else if (align == IndicatorAlign.top) {
      indicator = Positioned(
        left: 0.0,
        right: 0.0,
        top: 0.0,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.padding.left,
            right: widget.padding.right,
          ),
          child: indicator,
        ),
      );
    } else if (align == IndicatorAlign.center) {
      indicator = Center(
        child: Container(
          child: indicator,
          height: height,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: Container(
            height: widget.pageViewHeight,
            margin: EdgeInsets.only(
              top: widget.padding.top,
              bottom: widget.padding.bottom,
            ),
            child: pageView,
          ),
          onNotification: _onScroll,
        ),
        indicator,
      ],
    );
  }

  PageView get pageView => widget.child;

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final PageMetrics metrics = notification.metrics;
      currentPage = metrics.page;
      setState(() {});
    }
    return false;
  }

  void forceRefreshState() {
    this.setState(() {});
  }
}

class PageIndicator extends StatefulWidget {
  final Color color;

  final Color selectedColor;

  final int length;

  final double indicatorSpace;

  final IndicatorShape indicatorShape;

  final IndicatorAlign align;

  final bool reverse;

  final double currentPage;
  final double initialPage;

  const PageIndicator({
    Key key,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    @required this.length,
    @required this.currentPage,
    this.initialPage = 0,
    this.indicatorSpace = 5.0,
    this.indicatorShape = IndicatorShape.defaultCircle,
    this.align = IndicatorAlign.bottom,
    this.reverse = false,
  }) : super(key: key);

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter indicatorPainter;

    IndicatorShape shape = widget.indicatorShape;

    bool reverse = widget.reverse;

    final page = widget.currentPage ?? widget.initialPage;

    if (shape is OvalShape) {
      indicatorPainter = OvalPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
      );
    } else if (shape is RoundRectangleShape) {
      indicatorPainter = RRectPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
        cornerSize: shape.cornerSize,
      );
    } else if (shape is CircleShape) {
      indicatorPainter = CirclePainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        radius: shape.size / 2,
      );
    }

    return IgnorePointer(
      child: RotatedBox(
        quarterTurns: reverse ? 2 : 0,
        child: CustomPaint(
          child: Container(
            height: shape.height,
          ),
          size: Size.fromHeight(shape.height),
          painter: indicatorPainter,
        ),
      ),
    );
  }
}

class OvalPainter extends CustomPainter {
  double page;
  int count;
  Color color;
  Color selectedColor;
  double padding;
  Paint _circlePaint;
  Paint _selectedPaint;
  Size size;

  OvalPainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.padding = 5.0,
    this.size,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;

    this.page ??= 0.0;
    this.count ??= 0;
    this.color ??= Colors.white;
    this.selectedColor ??= Colors.grey;
    this.size ??= Size(12, 12);
    this.padding ??= 5.0;
  }

  double get totalWidth => count * size.width + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    var height = this.size.height;
    var width = this.size.width;
    var centerWidth = size.width / 2;
    var startX = centerWidth - totalWidth / 2;
    for (var i = 0; i < count ?? 0; i++) {
      var x = startX + i * (width + padding);
      var rect = Rect.fromLTWH(x, 0, width, height);
      canvas.drawOval(rect, _circlePaint);
    }

    var selectedX = startX + page * (width + padding);
    var rect = Rect.fromLTWH(selectedX, 0, width, height);
    canvas.drawOval(rect, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class RRectPainter extends CustomPainter {
  double page;
  int count;
  Color color;
  Color selectedColor;
  double padding;
  Paint _circlePaint;
  Paint _selectedPaint;
  Size size;
  Size cornerSize;

  RRectPainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.padding = 5.0,
    this.size,
    this.cornerSize,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;

    this.page ??= 0.0;
    this.count ??= 0;
    this.color ??= Colors.white;
    this.selectedColor ??= Colors.grey;
    this.size ??= Size(12, 12);
    this.padding ??= 5.0;
  }

  double get totalWidth => count * size.width + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    var height = this.size.height;
    var width = this.size.width;
    var centerWidth = size.width / 2;
    var startX = centerWidth - totalWidth / 2;
    for (var i = 0; i < count ?? 0; i++) {
      var x = startX + i * (width + padding);
      var rect = Rect.fromLTWH(x, 0, width, height);
      var rrect = RRect.fromRectAndRadius(
        rect,
        Radius.elliptical(cornerSize.width, cornerSize.height),
      );
      canvas.drawRRect(rrect, _circlePaint);
    }

    var selectedX = startX + page * (width + padding);
    var rect = Rect.fromLTWH(selectedX, 0, width, height);
    var rrect = RRect.fromRectAndRadius(
      rect,
      Radius.elliptical(cornerSize.width, cornerSize.height),
    );
    canvas.drawRRect(rrect, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CirclePainter extends CustomPainter {
  double page;
  int count;
  Color color;
  Color selectedColor;
  double radius;
  double padding;
  Paint _circlePaint;
  Paint _selectedPaint;

  CirclePainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.radius = 12.0,
    this.padding = 5.0,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;

    this.page ??= 0.0;
    this.count ??= 0;
    this.color ??= Colors.white;
    this.selectedColor ??= Colors.grey;
    this.radius ??= 12.0;
    this.padding ??= 5.0;
  }

  double get totalWidth => count * radius * 2 + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    var startX = size.width - totalWidth;
    for (var i = 0; i < count ?? 0; i++) {
      var x = startX + i * (radius * 2 + padding) + radius;
      canvas.drawCircle(Offset(x, radius), radius, _circlePaint);
    }

    var selectedX = startX + page * (radius * 2 + padding) + radius;
    canvas.drawCircle(Offset(selectedX, radius), radius, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}