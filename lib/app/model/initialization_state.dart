abstract class InitializationState {
  const InitializationState();
}

class InitializingState extends InitializationState {
  const InitializingState._const();

  factory InitializingState() {
    return const InitializingState._const();
  }
}

class InitializedState extends InitializationState {
  const InitializedState._const();

  factory InitializedState() {
    return const InitializedState._const();
  }
}

class ExceptionOnInitializeState extends InitializationState {
  final Exception exception;

  ExceptionOnInitializeState(this.exception);
}