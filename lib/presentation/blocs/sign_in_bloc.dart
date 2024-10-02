import 'package:bloc/bloc.dart';
import 'package:task_manager_app/domain/use_cases/sign_in_use_case.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_event.dart';
import 'package:task_manager_app/presentation/blocs/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonPressed>((event, emit) {
      print("BUTTON WORKING");
    });
  }

      // yield SignInLoading();
      // try {
      //   final user = await signInUseCase.signIn(
      //     event.email,
      //     event.password,
      //   );
      //   yield SignInSuccess(user: user);
      // } catch (e) {
      //   yield SignInFailure(error: e.toString());
      // }
}
