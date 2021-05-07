import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app/framework/navigation_service.dart';
import '../../../app/model/initialization_state.dart';
import '../../../app/model/loading_state.dart';

abstract class BaseViewModel extends Disposable {
  BaseViewModel(
    this.navigationService,
  ) {
    initializeListeners();

    if (autoInitialize) initialize();
  }

  final NavigationService navigationService;

  final initializationState = BehaviorSubject<InitializationState>.seeded(
    InitializingState(),
  );

  final List<StreamSubscription> subscriptions = [];
  final List<CancelableOperation> operations = [];

  bool get autoInitialize => true;

  void initializeListeners() {}

  void initialize() {
    request(
      firstLoad(),
      onError: (exception) => initializationState.add(
        ExceptionOnInitializeState(exception),
      ),
      onResult: (result) => initializationState.add(InitializedState()),
      onLoadBegin: () => initializationState.add(InitializingState()),
      showErrorMessageIf: (_) => false,
    );
  }

  void listenTo<T>(Stream<T> stream, ValueChanged<T> onNewValue) {
    subscriptions.add(
      stream.listen(
        (event) {
          onNewValue(event);
        },
      ),
    );
  }

  Future<void> firstLoad() async {}

  Future<T> request<T>(
    Future<T> future, {
    ValueChanged<Exception> onError,
    ValueChanged<T> onResult,
    Function() onLoadBegin,
    Subject<LoadingState> loadingSubject,
    Subject<Exception> errorSubject,
    Subject<T> resultSubject,
    bool Function(Exception) showErrorMessageIf,
  }) {
    if (loadingSubject?.isClosed == false)
      loadingSubject?.add(ActiveLoadingState());

    if (onLoadBegin != null) onLoadBegin();

    final cancelable = CancelableOperation<T>.fromFuture(
      future.then(
        (value) {
          if (onResult != null) onResult(value);

          if (loadingSubject?.isClosed == false)
            loadingSubject?.add(IdleState());

          if (resultSubject?.isClosed == false) resultSubject.add(value);
        },
      ).catchError(
        (error) {
          if(errorSubject?.isClosed == false) errorSubject.add(error);

          if (onError != null) onError(error);

          if (loadingSubject?.isClosed == false)
            loadingSubject?.add(ExceptionState(error));

          _handleError(error);
        },
      ),
    );

    operations.add(cancelable);

    return cancelable.value;
  }

  void bind<T>(Stream<T> stream, {@required BehaviorSubject<T> to}) {
    subscriptions.add(stream.listen((data) => to.add(data)));
  }

  void bindDistinct<T>(Stream<T> stream, {@required BehaviorSubject<T> to}) {
    subscriptions.add(
      stream.listen(
        (data) {
          if (data != to.value) to.add(data);
        },
      ),
    );
  }

  void _handleError(Exception exception) {}

  void goProgress(){
    navigationService.navigateToProgress();
  }

  void goBack(){
    navigationService.goBack();
  }

  void dispose() {
    subscriptions.forEach((subscription) => subscription.cancel());
    operations.forEach((operation) => operation.cancel());

    initializationState.close();
  }
}
