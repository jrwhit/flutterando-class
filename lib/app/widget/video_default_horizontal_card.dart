import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/base_media.dart';

class VideoDefaultHorizontalCard extends StatelessWidget {
  final BaseMedia media;
  static final double height = 120;
  VideoDefaultHorizontalCard(this.media);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: double.maxFinite,
            width: MediaQuery.of(context).size.width * 0.30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(
                  media?.imageUrl,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              media.title,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    color: AppColors.title,
                                  ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        media.subtitle,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: AppColors.subtitle,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
