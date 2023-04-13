import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/footer_tile.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const FooterTile(
        child: CircularProgressIndicator(),
      );
}

class NewPageProgressManual extends StatelessWidget {
  const NewPageProgressManual({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FooterTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Click load more.',
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
