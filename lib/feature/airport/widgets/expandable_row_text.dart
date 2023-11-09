import 'package:flutter/material.dart';

class ExpandableRowText extends StatelessWidget {
  const ExpandableRowText({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(firstText)),
        Expanded(child: Text(secondText)),
      ],
    );
  }
}
