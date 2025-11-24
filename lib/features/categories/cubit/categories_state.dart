part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final bool syncing;
  final String? error;

  const CategoriesState({
    this.syncing = false,
    this.error,
  });

  CategoriesState copyWith({bool? syncing, String? error}) => CategoriesState(
        syncing: syncing ?? this.syncing,
        error: error,
      );

  @override
  List<Object?> get props => [syncing, error];
}
