part of 'providers_cubit.dart';

class ProvidersState extends Equatable {
  final bool syncing;
  final String? error;

  const ProvidersState({
    this.syncing = false,
    this.error,
  });

  ProvidersState copyWith({bool? syncing, String? error}) => ProvidersState(
        syncing: syncing ?? this.syncing,
        error: error,
      );

  @override
  List<Object?> get props => [syncing, error];
}
