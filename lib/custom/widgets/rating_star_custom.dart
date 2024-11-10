import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const RatingStars({
    Key? key,
    required this.rating,
    this.starSize = 24,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    double halfStars = rating - fullStars;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < fullStars) {
            return Icon(
              Icons.star,
              size: starSize,
              color: color,
            );
          } else if (index == fullStars && halfStars > 0) {
            return Icon(
              Icons.star_half,
              size: starSize,
              color: color,
            );
          } else {
            return Icon(
              Icons.star_border,
              size: starSize,
              color: color,
            );
          }
        },
      ),
    );
  }
}
