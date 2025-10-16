import 'package:fashion_shop/screens/dashboard/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void changeBottomTabIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}