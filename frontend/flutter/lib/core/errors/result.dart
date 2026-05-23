import 'package:oncare/core/errors/app_error.dart';

/// A minimal `Result<T>` so repositories can return either a success
/// value or a typed [AppError] without throwing. Throwing is still
/// fine inside Riverpod's `AsyncValue`-friendly code paths — this is
/// for places where we want explicit handling.
sealed class Result<T> {
  const Result();

  factory Result.ok(T value) = Success<T>;
  factory Result.err(AppError error) = ResultError<T>;

  bool get isOk => this is Success<T>;
  bool get isError => this is ResultError<T>;

  T? get valueOrNull => switch (this) {
    Success<T>(:final T value) => value,
    ResultError<T>() => null,
  };

  AppError? get errorOrNull => switch (this) {
    Success<T>() => null,
    ResultError<T>(:final AppError error) => error,
  };

  R fold<R>({
    required R Function(T value) ok,
    required R Function(AppError error) err,
  }) => switch (this) {
    Success<T>(:final T value) => ok(value),
    ResultError<T>(:final AppError error) => err(error),
  };
}

class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

class ResultError<T> extends Result<T> {
  const ResultError(this.error);
  final AppError error;
}
