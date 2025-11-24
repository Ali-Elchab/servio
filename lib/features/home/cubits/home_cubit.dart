import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()  : super(HomeInitial());
  static final HomeCubit instance = HomeCubit();

  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  void increment() => counter.value++;
}
