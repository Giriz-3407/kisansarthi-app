import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/auth/presentation/auth_notifier.dart';
import 'package:kisansarthi/features/auth/presentation/auth_state.dart';
import 'package:kisansarthi/features/auth/presentation/login_screen.dart';
import 'package:kisansarthi/features/auth/presentation/register_screen.dart';
import 'package:kisansarthi/features/dashboard/presentation/dashboard_screen.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_screen.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_screen.dart';
import 'package:kisansarthi/features/farms/presentation/add_farm_screen.dart';
import 'package:kisansarthi/features/farms/presentation/edit_farm_screen.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_screen.dart';
import 'package:kisansarthi/features/lands/presentation/add_land_screen.dart';
import 'package:kisansarthi/features/soil/presentation/add_soil_reading_screen.dart';
import 'package:kisansarthi/features/soil/presentation/soil_monitoring_screen.dart';
import 'package:kisansarthi/features/diagnostics/presentation/scan_screen.dart';
import 'package:kisansarthi/features/diagnostics/presentation/diagnostic_result_screen.dart';
import 'package:kisansarthi/features/recommendations/presentation/crop_suggestions_screen.dart';
import 'package:kisansarthi/features/recommendations/presentation/fertilizer_screen.dart';
import 'package:kisansarthi/features/market/presentation/market_screen.dart';
import 'package:kisansarthi/features/profile/presentation/profile_screen.dart';
import 'package:kisansarthi/features/plantings/presentation/add_planting_screen.dart';
import 'package:kisansarthi/features/devices/presentation/link_device_screen.dart';
import 'package:kisansarthi/shared/models/farm.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isAuth = authState is Authenticated;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isAuth && !isLoggingIn) return '/login';
      if (isAuth && isLoggingIn) return '/dashboard';

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _calculateSelectedIndex(state.matchedLocation),
              onDestinationSelected: (index) {
                switch (index) {
                  case 0: context.go('/dashboard'); break;
                  case 1: context.go('/scan'); break;
                  case 2: context.go('/market'); break;
                  case 3: context.go('/profile'); break;
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Farms'),
                NavigationDestination(icon: Icon(Icons.camera_alt), label: 'Scan'),
                NavigationDestination(icon: Icon(Icons.store), label: 'Market'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
        routes: [
          GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
          GoRoute(
            path: '/scan',
            builder: (context, state) {
              final landId = int.tryParse(state.uri.queryParameters['landId'] ?? '');
              return ScanScreen(landId: landId);
            },
          ),
          GoRoute(
            path: '/market',
            builder: (context, state) {
              final landId = int.tryParse(state.uri.queryParameters['landId'] ?? '');
              return MarketScreen(landId: landId);
            },
          ),
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        ],
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: '/farms/add',
        builder: (context, state) => const AddFarmScreen(),
      ),
      GoRoute(
        path: '/farms/edit',
        builder: (context, state) {
          final farm = state.extra as Farm;
          return EditFarmScreen(farm: farm);
        },
      ),
      GoRoute(
        path: '/farms/:farmId',
        builder: (context, state) {
          final farmId = int.parse(state.pathParameters['farmId']!);
          return FarmDetailScreen(farmId: farmId);
        },
      ),
      GoRoute(
        path: '/farms/:farmId/lands/add',
        builder: (context, state) {
          final farmId = int.parse(state.pathParameters['farmId']!);
          return AddLandScreen(farmId: farmId);
        },
      ),
      GoRoute(
        path: '/lands/:landId',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return LandDetailScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/manual-soil',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return AddSoilReadingScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/soil-monitoring',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return SoilMonitoringScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/crop-suggestions',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return CropSuggestionsScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/selected-crop',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return SelectedCropScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/fertilizer',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return FertilizerScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/lands/:landId/plantings/add',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          final cropName = state.uri.queryParameters['cropName'];
          return AddPlantingScreen(landId: landId, initialCropName: cropName);
        },
      ),
      GoRoute(
        path: '/lands/:landId/link-device',
        builder: (context, state) {
          final landId = int.parse(state.pathParameters['landId']!);
          return LinkDeviceScreen(landId: landId);
        },
      ),
      GoRoute(
        path: '/diagnostics/result/:logId',
        builder: (context, state) {
          final logId = int.parse(state.pathParameters['logId']!);
          return DiagnosticResultScreen(logId: logId);
        },
      ),
    ],
  );
});

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/dashboard')) return 0;
  if (location.startsWith('/scan')) return 1;
  if (location.startsWith('/market')) return 2;
  if (location.startsWith('/profile')) return 3;
  return 0;
}
