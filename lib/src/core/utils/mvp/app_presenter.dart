import 'package:ankabootmobile/src/core/utils/mvp/app_model.dart';
import 'package:ankabootmobile/src/core/utils/mvp/app_view.dart';
import 'package:flutter/widgets.dart';

abstract class AppPresenter<V extends AppView, M extends AppModel> {
  V? _view;

  @protected
  abstract final M model;

  @protected
  V? get view => _view;

  @mustCallSuper
  void bindView(V view) {
    this._view = view;
  }

  @mustCallSuper
  void dispose() {
    _view = null;
  }

  @visibleForTesting
  V? getViewTest() => view;

  Widget buildMultiBlocListener(
    BuildContext context,
    Widget child, {
    Key? key,
  });
}
