import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/provider.dart';
import '../data/repositories/providers_repository.dart';

part 'providers_state.dart';

class ProvidersCubit extends Cubit<ProvidersState> {
  final ProvidersRepository repo;
  ProvidersCubit(this.repo) : super(const ProvidersState());

  Future<void> load({bool force = false}) async {
    emit(state.copyWith(syncing: true, error: null));
    try {
      await repo.sync(force: force);
      emit(state.copyWith(syncing: false));
    } catch (e) {
      emit(state.copyWith(syncing: false, error: e.toString()));
    }
  }

  Stream<List<Provider>> watch() => repo.watch();
}
