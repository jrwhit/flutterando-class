import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterando_class/app/core/constants/images.dart';
import 'package:flutterando_class/app/widget/media_progress_item.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/media_cached.dart';

class VideoCachedHorizontalCard extends StatelessWidget {
  final MediaCached cached;
  static final double height = 120;
  VideoCachedHorizontalCard(this.cached);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: height,
                width: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      cached.content?.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              _buildButton(context),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cached.content.title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: AppColors.accent,
                              ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.ellipsis_vertical,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cached.content.description,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: AppColors.subtitle,
                            ),
                      ),
                      Text(
                        "${_currentPercentage()}%",
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: AppColors.subtitle,
                            ),
                      ),
                    ],
                  ),
                  MediaProgressItem(
                      duration: cached.content.duration,
                      currentProgress: cached.currentProgress),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) => FloatingActionButton(
        heroTag: "play",
        elevation: 0,
        mini: true,
        isExtended: false,
        child: Icon(
          _unfinishedMedia()
              ? CupertinoIcons.arrow_counterclockwise
              : CupertinoIcons.play_arrow_solid,
          size: 20,
          color: AppColors.accent,
        ),
        onPressed: () {},
        backgroundColor: AppColors.floatingButton,
      );

  bool _unfinishedMedia() {
    return cached.currentProgress == cached.content.duration;
  }

  String _currentPercentage() {
    return ((100 * cached.currentProgress.inMicroseconds) /
            cached.content.duration.inMicroseconds)
        .toStringAsPrecision(3);
  }
}
