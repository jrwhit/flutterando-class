import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';

class HeaderTitle extends StatelessWidget {
  final bool buildTag;
  final bool buildFeaturedTitle;
  final bool buildBackgroundSvg;
  final BorderRadius radius = BorderRadius.circular(10);
  final double height = 40;
  final String title;
  final String pathSvg;

  HeaderTitle(this.title,
      {this.buildTag = false,
      this.buildFeaturedTitle = false,
      this.buildBackgroundSvg = false, this.pathSvg = " "});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildFeaturedTitle
              ? _buildFeaturedTitle(context, title, pathSvg, buildBackgroundSvg)
              : _buildDefaultTitle(context, title),
          _buildLabelSeeAll(context),
        ],
      ),
    );
  }

  Widget _buildLabelSeeAll(BuildContext context) => Visibility(
    visible: buildTag,
    child: GestureDetector(
      child: Row(
        children: [
          Text(
            "ver todos",
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
      ),
      onTap: buildTag
          ? () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Sendo implementado"),
          ),
        );
      }
          : null,
    ),
  );

  Widget _buildDefaultTitle(BuildContext context, title) => Text(
    title,
    style: Theme.of(context)
        .textTheme
        .headline3
        .copyWith(color: AppColors.subtitle),
  );

  Widget _buildFeaturedTitle(BuildContext context, String title, String pathSvg, bool buildSvg) => Stack(
    alignment: Alignment.centerLeft,
    children: [
      buildSvg ? Image.asset(pathSvg) : Container(),
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "${title.split(" ")[0]} ",
                style: Theme.of(context).textTheme.headline3.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              TextSpan(
                text: title.split(" ")[1],
                style: Theme.of(context).textTheme.headline3.copyWith(
                  color: AppColors.accent,
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
