import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/video.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  static final double height = 120;
  VideoCard(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(
            video?.imageUrl,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
