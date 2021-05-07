import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_class/app/core/constants/colors.dart';
import 'package:flutterando_class/app/model/initialization_state.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutterando_class/app/view_model/base/base_view_model.dart';

abstract class BaseViewState<T extends StatefulWidget, R extends BaseViewModel>
    extends ModularState<T, R> with AutomaticKeepAliveClientMixin {
  R get viewModel => controller;

  void doBeforeViewModelInitialization() {}

  @override
  void didChangeDependencies() {
    if (viewModel == null) {

      viewModel;

      doBeforeViewModelInitialization();

      viewModel.initializeListeners();

      if (viewModel.autoInitialize) viewModel.initialize();
    }
    super.didChangeDependencies();
  }

  @protected
  Widget buildParent(BuildContext context, Widget child) {
    return Scaffold(
      body: child,
      backgroundColor: scaffoldBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<InitializationState>(
      stream: viewModel.initializationState,
      builder: (context, snapshot) {
        var state = snapshot.data;

        Widget child;

        switch (state?.runtimeType) {
          case InitializingState:
            child = buildInitializingState(context);
            break;
          case ExceptionOnInitializeState:
            child = buildExceptionOnInitializeState(
              context,
              (state as ExceptionOnInitializeState).exception,
            );
            break;
          case InitializedState:
            child = buildInitializedState(context);
            break;
          default:
            child = Container();
            break;
        }

        return needsParent ? buildParent(context, child) : child;
      },
    );
  }

  @protected
  Widget buildInitializingState(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @protected
  Widget buildExceptionOnInitializeState(
    BuildContext context,
    Exception exception,
  ) {
    return Center(
      child: Text(exception.toString()),
    );
  }

  @protected
  Widget buildLoadingContainer(
    BuildContext context,
    BehaviorSubject<bool> loadingStream,
    TickerProvider tickerProvider,
    String loadingText,
  ) {
    return StreamBuilder<bool>(
      stream: loadingStream,
      builder: (context, snapshot) {
        return AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          vsync: tickerProvider,
          child: Container(
            color: Colors.grey[400],
            padding: EdgeInsets.all(20),
            height: snapshot.data == true ? null : 0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    loadingText,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @protected
  Widget buildInitializedState(BuildContext context);

  Color get scaffoldBackgroundColor => AppColors.accent;

  bool get needsParent => true;

  @override
  bool get wantKeepAlive => false;
}
