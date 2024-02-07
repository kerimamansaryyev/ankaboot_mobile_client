import 'dart:ui';

import 'package:ankabootmobile/src/core/ui/colors/context_color_extension.dart';
import 'package:flutter/material.dart';

class LoadWrapper extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadWrapper({
    required this.isLoading,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: child,
        ),
        if (isLoading)
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: context.colors.loaderWrapperBackgroundColor
                      .withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
