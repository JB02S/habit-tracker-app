
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/add_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_event.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import '../../domain/use_cases/get_habit_usecase.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {

  final GetHabitsUsecase _getHabitsUseCase;
  final AddHabitUsecase _addHabitUseCase;

  HabitBloc(this._getHabitsUseCase, this._addHabitUseCase) : super(HabitLoading()) {
    // Listen for get habits event
    on <GetHabitsEvent> (onGetHabitsEvent);
  }

  Future<void> onGetHabitsEvent(GetHabitsEvent event, Emitter <HabitState> emit) async {
    emit(HabitLoading());
    await _getHabitsUseCase.execute();

  }
}