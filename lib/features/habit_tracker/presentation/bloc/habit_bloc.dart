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
    on <GetHabitsEvent> (onGetHabitsEvent);
    on <AddHabitEvent> (onAddHabitsEvent);
  }

  Future<void> onGetHabitsEvent(GetHabitsEvent event, Emitter<HabitState> emit) async {
    emit(HabitLoading());
    try {
      final habits = await _getHabitsUseCase.execute(); // Fetch the habits
      emit(HabitLoaded(habits)); // Emit loaded state with habits
    } catch (e) {
      emit(HabitError("Failed to load habits")); // Emit error state on failure
    }
  }

  Future<void> onAddHabitsEvent(AddHabitEvent event, Emitter<HabitState> emit) async {
    emit(HabitLoading());
    await _addHabitUseCase.execute(event.habit);

    final habits = await _getHabitsUseCase.execute();
    emit(HabitLoaded(habits));
  }

}