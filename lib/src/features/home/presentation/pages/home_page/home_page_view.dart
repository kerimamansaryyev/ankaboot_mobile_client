import 'package:ankabootmobile/src/core/utils/mvp/app_view.dart';
import 'package:flutter/material.dart';

abstract interface class HomePageView implements AppView {
  void showErrorDialog(
    BuildContext context,
    String message,
  );
}
