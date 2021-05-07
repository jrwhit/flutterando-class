import 'package:flutter/material.dart';

import '../../../app/view_model/base/base_view_model.dart';
import '../../../main.dart';

import 'base_view_state.dart';

abstract class BaseScreenViewState<T extends StatefulWidget,
    R extends BaseViewModel> extends BaseViewState<T, R> with RouteAware {
  @override
  @mustCallSuper
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPush() {
    didAppear();
  }

  @override
  void didPopNext() {
    didAppear();
  }

  @override
  void didPop() {
    didDisappear();
  }

  @override
  void didPushNext() {
    didDisappear();
  }

  void didAppear() {}

  void didDisappear() {}
}
