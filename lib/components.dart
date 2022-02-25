import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final String price;
  final String iconPath;
  final bool topLine;
  final bool bottomLine;

  const ReusableCard(
      {Key? key, required this.title, required this.price, required this.iconPath, required this.topLine, required this.bottomLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: topLine ? 1 : 0,
          width: double.infinity,
          color: primaryTextColor.withOpacity(0.7),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 32,
                height: 32,
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: Text(title, style: bodyTextStyle),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                price,
                style: priceTextStyle,
              )
            ],
          ),
        ),
        Container(
          height: bottomLine ? 1 : 0,
          width: double.infinity,
          color: primaryTextColor.withOpacity(0.7),
        ),
      ],
    );
  }
}
