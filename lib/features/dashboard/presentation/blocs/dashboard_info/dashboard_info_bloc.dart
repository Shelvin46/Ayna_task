import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_info_event.dart';
part 'dashboard_info_state.dart';

/// [DashboardInfoBloc] is a [Bloc] that takes [DashboardInfoEvent] as an input and emits [DashboardInfoState] as an output.
/// It is used to manage the state of the dashboard screen.
/// It has one event:
/// 1. [DashboardInfoFetch] is the event that is used to fetch the user's name from Firestore.
class DashboardInfoBloc extends Bloc<DashboardInfoEvent, DashboardInfoState> {
  DashboardInfoBloc() : super(DashboardInfoInitial()) {
    on<DashboardInfoFetch>((event, emit) async {
      emit(DashboardInfoLoading());

      final result = await locator<DashboardUseCases>().executeGetDashboardInfo(
        event.userEntity,
      );

      result.fold(
        (failure) => emit(DashboardInfoError(failure.message)),
        (userName) => emit(DashboardInfoLoaded(userName)),
      );
    });
  }
}
