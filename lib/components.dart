import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

class ReusableSection extends StatelessWidget {
  final String title;
  final int cardNumber;
  final List<String> titles;
  final List<String> prices;
  final List<String> iconPaths;

  const ReusableSection(
      {Key? key, required this.title, required this.cardNumber, required this.titles, required this.prices, required this.iconPaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Text(
            title,
            style: titleTextStyle,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        for (int i = 0; i < cardNumber; i++)
          ReusableCard(
              title: titles[i], price: prices[i], iconPath: iconPaths[i], topLine: true, bottomLine: i + 1 == cardNumber ? true : false)
      ],
    );
  }
}

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
              Row(
                mainAxisSize: MainAxisSize.min,
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
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: Text(
                  price,
                  textAlign: TextAlign.end,
                  style: priceTextStyle,
                ),
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
