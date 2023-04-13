import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/footer_tile.dart';

class NewPageErrorIndicator extends StatelessWidget {
  const NewPageErrorIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FooterTile(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Something went wrong. Tap to try again.',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 4,
        ),
        Icon(
          Icons.refresh,
          size: 16,
        ),
      ],
    ),
  );
}
