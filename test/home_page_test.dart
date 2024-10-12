import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/pages/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitBloc extends Mock implements HabitBloc {}

void main() {

  late MockHabitBloc mockHabitBloc;

  setUp(() {
    mockHabitBloc = MockHabitBloc();

    when(() => mockHabitBloc.stream).thenAnswer(
            (_) => Stream<HabitState>.fromIterable([
          HabitInitial(), HabitLoading(), HabitLoaded([])
        ])
    );

    when(() => mockHabitBloc.state).thenReturn(HabitInitial());
  });

  group('rendering tests', () {

    testWidgets('renders HomePage test', (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: HomePage()
          ),
        )
      );

      expect(find.byType(HomePage), findsOneWidget);

    });

    testWidgets('displays loading indicator when state is HabitLoading', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: HomePage(),
          ),
        )
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders correctly during state HabitLoaded with no habits', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded([]));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: HomePage()
          ),
        )
      );

      expect(find.text('You have no habits'), findsOneWidget);

    });

    testWidgets('renders correctly during state HabitLoaded with habits', (WidgetTester tester) async {

      // Issue with this tests, fails if the number of tests needs to be scrolled down to be seen, e.g generateHabits(n > 9)
      // Also want to add description summary check, still need to implement this feature
      final List<HabitEntity> habits = generateHabits(8);

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded(habits));

      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<HabitBloc>.value(
                value: mockHabitBloc,
                child: HomePage()
            ),
          )
      );

      for (final habit in habits) {
        expect(find.text(habit.title), findsOneWidget);
      }

    });


  });
}

// seeder to generate habits
List<HabitEntity> generateHabits(int count) {
  const title = 'Title';
  const description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

  return List.generate(count, (index) {
    return HabitEntity(
      title: '$title $index',
      description: '$description $index',
    );
  });
}
