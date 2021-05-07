import 'package:flutter/material.dart';

import '../../app/core/constants/colors.dart';
import '../../app/model/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  static final double height = 120;
  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context, book.imageUrl),
          _buildText(context, book.title, book.subtitle),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, String pathImage) => Container(
    height: 260,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      image: DecorationImage(
        image: AssetImage(
          book?.imageUrl,
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