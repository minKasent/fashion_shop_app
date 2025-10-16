import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/screens/home/home_screen.dart';
import 'package:fashion_shop/screens/notification/notification_screen.dart';
import 'package:fashion_shop/screens/orders/order_screen.dart';
import 'package:fashion_shop/screens/setting/setting_screen.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/dashboard_cubit.dart';
import 'cubit/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: const [
                HomeScreen(),
                NotificationScreen(),
                OrderScreen(),
                SettingScreen(),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBarWidget(
              context,
              state: state,
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBarWidget(
    BuildContext context, {
    required DashboardState state,
  }) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColorSchemes.purple,
      unselectedItemColor: AppColorSchemes.darkGrey,
      elevation: 10,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: state.currentIndex,
      onTap: (index) {
        context.read<DashboardCubit>().changeBottomTabIndex(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.home.path), size: 24),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(Assets.icons.notificationbing.path),
            size: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.receipt.path), size: 24),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Assets.icons.profile.path), size: 24),
          label: '',
        ),
      ],
    );
  }
}
