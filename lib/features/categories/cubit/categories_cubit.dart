import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/features/categories/data/models/category.dart';
import '/features/categories/data/repositories/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository repo;
  CategoriesCubit(this.repo) : super(const CategoriesState());

  Future<void> load({bool force = false}) async {
    emit(state.copyWith(syncing: true, error: null));
    try {
      await repo.sync(force: force);
      emit(state.copyWith(syncing: false));
    } catch (e) {
      emit(state.copyWith(syncing: false, error: e.toString()));
    }
  }

  Stream<List> watchRoots() => repo.watchRoots();

  Stream<List> watchChildren(int parentId) => repo.watchChildren(parentId);
}
