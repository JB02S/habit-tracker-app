import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_state.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/pages/add_habit_page.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/pages/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitBloc extends Mock implements HabitBloc {}

class MockHabitRepository extends Mock implements HabitRepository {}

void main() {

  late MockHabitBloc mockHabitBloc;
  late MockHabitRepository mockHabitRepository;
  late List<HabitEntity> habits;

  setUp(() {

    mockHabitBloc = MockHabitBloc();
    mockHabitRepository = MockHabitRepository();
    habits = generateHabits(8);

    when(() => mockHabitBloc.stream).thenAnswer(
            (_) => Stream<HabitState>.fromIterable([
          HabitInitial(), HabitLoading(), HabitLoaded([])
        ])
    );

    when(() => mockHabitBloc.state).thenReturn(HabitInitial());
    GetIt.I.registerSingleton<HabitRepository>(mockHabitRepository);
    GetIt.I.registerSingleton<HabitBloc>(mockHabitBloc);

  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('rendering tests', () {

    testWidgets('renders HomePage test', (WidgetTester tester) async {

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);

    });

    testWidgets('displays loading indicator when state is HabitLoading', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoading());

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders correctly during state HabitLoaded with no habits', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded([]));

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.text('You have no habits'), findsOneWidget);

    });

    testWidgets('renders correctly during state HabitLoaded with habits', (WidgetTester tester) async {

      // Issue with this tests, fails if the number of tests needs to be scrolled down to be seen, e.g no. of habits > 9
      // Also want to add description summary check, still need to implement this feature

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded(habits));

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      for (final habit in habits) {
        expect(find.text(habit.title), findsOneWidget);
      }

    });

    testWidgets('test edit button renders', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded([]));

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      final Finder editButton = find.byIcon(Icons.edit);
      expect(editButton, findsOneWidget);

    });

    testWidgets('test add button renders', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded([]));

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      final Finder editButton = find.byIcon(Icons.add);
      expect(editButton, findsOneWidget);

    });

  });

  group('icon button functionality tests', () {

    testWidgets('test edit button tap toggles delete button visibility', (WidgetTester tester) async {

      when(() => mockHabitBloc.state).thenReturn(HabitLoaded(habits));

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      final Finder editButton = find.byIcon(Icons.edit);
      await tester.tap(editButton);
      await tester.pumpAndSettle();
      final Finder deleteButton = find.byIcon(Icons.delete);
      final Finder addButton = find.byIcon(Icons.add);

      expect(addButton, findsNothing);
      expect(deleteButton, findsOneWidget);

      await tester.tap(editButton);
      await tester.pumpAndSettle();

      expect(addButton, findsOneWidget);
      expect(deleteButton, findsNothing);

    });

    // TODO: Fix this test!!, the Checkboxes are in the widget tree but the test can't find them after edit is pressed for some reason
    // testWidgets('test edit button tap toggles checkbox visibility', (WidgetTester tester) async {
    //
    //   when(() => mockHabitBloc.state).thenReturn(HabitLoaded(habits));
    //
    //   await tester.pumpWidget(
    //     BlocProvider<HabitBloc>.value(
    //       value: mockHabitBloc,
    //       child: MaterialApp(
    //         home: HomePage(),
    //       ),
    //     ),
    //   );

    //   expect(find.byType(Checkbox), findsNWidgets(habits.length));
    //
    //   for (int i = 0; i < habits.length; i++) {
    //     final checkboxFinder = find.byType(Checkbox).at(i);
    //     expect(tester.getTopLeft(checkboxFinder).dx, lessThan(0));
    //   }
    //
    //   final Finder editButton = find.byIcon(Icons.edit);
    //   await tester.tap(editButton);
    //   await tester.pumpAndSettle();
    //
    //   await tester.tap(editButton);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(Checkbox), findsNWidgets(habits.length));
    //
    //   for (int i = 0; i < habits.length; i++) {
    //     final checkboxFinder = find.byType(Checkbox).at(i);
    //     expect(tester.getTopLeft(checkboxFinder).dx, greaterThanOrEqualTo(0));
    //   }
    //
    // });


    // important note, when navigator button called it pushes page right below materialapp, https://stackoverflow.com/questions/67356450/flutter-could-not-find-the-correct-providerbloc-after-navigating-to-different,
    // so need to always ensure that MaterialApp is within the BlocProvider so descendant widgets can access
    testWidgets('test add button', (WidgetTester tester) async {
      when(() => mockHabitBloc.state).thenReturn(HabitLoaded([]));
      when(() => mockHabitRepository.getHabits()).thenAnswer((_) async => habits);

      await tester.pumpWidget(
        BlocProvider<HabitBloc>.value(
          value: mockHabitBloc,
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      final Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.byType(AddHabitPage), findsOneWidget);

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
