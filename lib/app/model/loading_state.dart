abstract class LoadingState {
  const LoadingState();
}

class IdleState extends LoadingState {
  const IdleState._const();

  factory IdleState() {
    return const IdleState._const();
  }
}

class ActiveLoadingState extends LoadingState {
  const ActiveLoadingState._const();

  factory ActiveLoadingState() {
    return const ActiveLoadingState._const();
  }
}

class ExceptionState extends LoadingState {
  final Exception exception;

  ExceptionState(this.exception);
}