import 'package:flutter/cupertino.dart';
import 'package:flutterando_class/app/core/constants/colors.dart';

class MediaProgressItem extends StatelessWidget {
  final Duration duration;
  final Duration currentProgress;

  final int height;

  final Color backgroundColor;
  final Color progressColor;

  const MediaProgressItem({
    Key key,
    @required this.duration,
    @required this.currentProgress,
    this.backgroundColor,
    this.progressColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final progress = currentProgress != null && duration != null
            ? (currentProgress.inMicroseconds / duration.inMicroseconds)
            .toDouble()
            : 0.0;

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: height ?? 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: backgroundColor ?? AppColors.secondary,
              ),
              width: constraints.biggest.width,
            ),
            Container(
              height: height ?? 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: progressColor ?? AppColors.accent,
              ),
              width: constraints.biggest.width * progress,
            ),
          ],
        );
      },
    );
  }
}