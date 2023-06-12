import 'package:flutter/material.dart';
import 'package:tua/constants/textstyles.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    this.label,
    Key? key,
  }) : super(key: key);
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          Flexible(
            child: Text(
              label ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyles.h2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
