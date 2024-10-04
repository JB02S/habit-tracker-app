
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/add_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_event.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import '../../domain/use_cases/get_habit_usecase.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {

  final GetHabitUsecase _getHabitUseCase;
  final AddHabitUsecase _addHabitUseCase;

  HabitBloc(this._getHabitUseCase, this._addHabitUseCase) : super(HabitInitial());

}