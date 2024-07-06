part of 'dashboard_info_bloc.dart';

/// [DashboardInfoEvent] is a sealed class that extends [Equatable] to make the [DashboardInfoEvent] object comparable.
/// It has one event:
/// 1. [DashboardInfoFetch] is the event that is used to fetch the user's name from Firestore.
sealed class DashboardInfoEvent extends Equatable {
  const DashboardInfoEvent();

  @override
  List<Object> get props => [];
}

final class DashboardInfoFetch extends DashboardInfoEvent {
  final UserEntity userEntity;

  const DashboardInfoFetch({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}
