import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/base_media.dart';

class BannerCard extends StatelessWidget {
  final BaseMedia media;
  final Function onClick;
  BannerCard(this.media, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: AssetImage(
                media?.imageUrl,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: const Alignment(0.0, -1.0),
              end: const Alignment(0.0, 1.0),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(context),
            _buildText(context),
          ],
        )
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      children: [
        Text(
          media.title,
          maxLines: 2,
          style: Theme.of(context).textTheme.headline1.copyWith(
                color: AppColors.secondary,
                fontSize: 14,
              ),
          overflow: TextOverflow.fade,
        ),
        SizedBox(
          height: 70,
          width: 230,
          child: Column(
            children: [
              Text(
                media.subtitle.split("Comunidade")[0],
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.secondary,
                    ),
              ),
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    media.subtitle.split(" ").last,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = AppColors.secondary,
                        ),
                  ),
                  // Solid text as fill.
                  Text(
                    media.subtitle.split(" ").last,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 60,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Image.asset("assets/img/logo/logo_white.png", scale: 60),
            onTap: onClick,
          ),
          Image.asset(
            "assets/img/logo/flagBr.png",
            scale: 22,
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton.icon(
          color: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {},
          icon: Icon(Icons.play_arrow),
          label: Text(
            "assistir",
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColors.primary,
                ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        RaisedButton.icon(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppColors.secondary,
              width: 1,
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.add, color: AppColors.secondary,),
          label: Text(
            "detalhes",
            style: Theme.of(context).textTheme.button.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
