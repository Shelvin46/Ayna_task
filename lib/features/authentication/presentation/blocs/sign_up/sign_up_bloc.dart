import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/usecases/sign_up_usecases.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

///[SignUpBloc] is a [Bloc] that handles the sign up event
///It extends [Bloc] and takes [SignUpEvent] and [SignUpState]
///It has a constructor that takes [SignUpInitial] state
///It has a method that listens to [SignUpButtonPressed] event
///and emits [SignUpLoading] state
///It then creates a [UserEntity] object and calls [SignUpUseCases] to execute sign up
///It then emits [SignUpFailure] or [SignUpSuccess] state based on the result
///of the sign up process
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());

      final userEntity = UserEntity(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      final result = await locator<SignUpUseCases>().executeSignUp(userEntity);

      result.fold((value) {
        return emit(SignUpFailure(message: value.message));
      }, (value) {
        return emit(SignUpSuccess(user: value));
      });
    });
  }
}
