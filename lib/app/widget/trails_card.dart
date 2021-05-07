import 'package:flutter/material.dart';
import 'package:flutterando_class/app/core/constants/constants.dart';
import 'package:flutterando_class/app/core/constants/images.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/trail.dart';

class TrailsCard extends StatelessWidget {
  final Trail trail;
  static final double height = 120;
  TrailsCard(this.trail);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSecondary,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.trailsSvg,
                    scale: 50,
                  ),
                  SizedBox(width: 8,),
                  Flexible(
                    child: Text(
                      trail.title,
                      maxLines: 2,
                      style:
                      Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 14,
                        color: AppColors.title,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              trail.type == TypeTrail.video ? Row(
                children: [
                  Text(
                    "Assistir",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.accent,
                    size: 12,
                  ),
                ],
              ) : Container(),
            ],
          ),
          Text(
            trail.subtitle,
            maxLines: 3,
            style: Theme.of(context).textTheme.headline5.copyWith(
              color: AppColors.subtitle,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
