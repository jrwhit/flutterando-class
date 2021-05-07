import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/playlist.dart';

class PlayListCard extends StatelessWidget {
  final PlayList playList;
  static final double height = 120;
  PlayListCard(this.playList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context, playList.imageUrl),
          _buildText(context, playList.title, playList.subtitle),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, String pathImage) => Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage(
              playList?.imageUrl,
            ),
            fit: BoxFit.fill,
          ),
        ),
      );

  Widget _buildText(BuildContext context, String title, String subtitle) =>
      Padding(
        padding: EdgeInsets.only(left: 4, top: 18,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              maxLines: 2,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: AppColors.title,
                  ),
              overflow: TextOverflow.fade,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: AppColors.subtitle,
                  ),
            ),
          ],
        ),
      );
}
