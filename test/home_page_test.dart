import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/pages/home_page.dart';

import 'package:mockito/mockito.dart';

class MockHabitBloc extends Mock implements HabitBloc {}

void main() {
  
  group('testing HomePage functions', () {

    late MockHabitBloc mockHabitBloc;

    setUp(() {
      mockHabitBloc = MockHabitBloc();

      when(mockHabitBloc.stream).thenAnswer(
            (_) => Stream.value(HabitInitial()), // Replace with the actual initial state of your HabitState
      );

      when(mockHabitBloc.state).thenReturn(HabitInitial());

    });

    testWidgets('renders HomePage correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: HomePage()
          ),
        )
      );
    });

    // test('', () {expect(1, 1);});

  });

}
