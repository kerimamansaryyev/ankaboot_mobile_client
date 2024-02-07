import 'package:ankabootmobile/src/core/utils/mvp/app_view.dart';
import 'package:flutter/cupertino.dart';

abstract interface class CreateAMSAPIPageView implements AppView {
  void showSuccessDialog(BuildContext context, String message);
  void showErrorDialog(BuildContext context, String message);
  void popScreen();
}
