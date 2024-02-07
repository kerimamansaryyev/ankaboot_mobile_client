import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:flutter/material.dart';

class ErrorListWidget extends StatelessWidget {
  final String text;
  final VoidCallback refreshCallback;

  const ErrorListWidget({
    required this.text,
    required this.refreshCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          1.gap,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            1.hBox,
            FilledButton(
              onPressed: refreshCallback,
              child: Text(
                context.translation.tryAgain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
