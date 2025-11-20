import 'package:flutter/material.dart';

// THEMES
import 'theme/app_colors.dart';
import 'theme/app_styles.dart';

// ROUTES
import 'navigation/routes.dart';

// CONSTANTS
import 'constants.dart';

// SCREENS
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

import 'screens/home_screen.dart';

import 'screens/farm/farm_dashboard.dart';
import 'screens/farm/plot_detail_screen.dart';
import 'screens/farm/crop_detail_screen.dart';

import 'screens/marketplace/seedling_market.dart';
import 'screens/marketplace/supplier_detail.dart';

import 'screens/learning/training_hub.dart';
import 'screens/learning/course_detail.dart';

import 'screens/weather/weather_dashboard.dart';

import 'screens/settings/profile_screen.dart';
import 'screens/settings/preferences_screen.dart';

import 'models/farm.dart';
import 'models/crop.dart';
import 'models/supplier.dart';
import 'models/training_course.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: buildAppTheme(),
      initialRoute: Routes.splash,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  // ========================================================
  // CLEAN ROUTE HANDLER (SMART + ARGUMENT SAFE)
  // ========================================================
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // FARM
      case Routes.farmDashboard:
        return MaterialPageRoute(builder: (_) => const FarmDashboard());

      case Routes.plotDetail:
        final farm = settings.arguments as Farm;
        return MaterialPageRoute(builder: (_) => PlotDetailScreen(farm: farm));

      case Routes.cropDetail:
        final crop = settings.arguments as Crop;
        return MaterialPageRoute(
          builder: (_) => CropDetailScreen(crop: crop),
        );

      // MARKETPLACE (with arguments)
      case Routes.seedlingMarket:
        return MaterialPageRoute(builder: (_) => const SeedlingMarketScreen());

      case Routes.supplierDetail:
        final supplier = settings.arguments as Supplier;
        return MaterialPageRoute(
          builder: (_) => SupplierDetailScreen(supplier: supplier),
        );

      // LEARNING
      case Routes.trainingHub:
        return MaterialPageRoute(builder: (_) => const TrainingHubScreen());

      case Routes.courseDetail:
        final course = settings.arguments as TrainingCourse;
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(course: course),
        );

      // WEATHER
      case Routes.weather:
        return MaterialPageRoute(builder: (_) => const WeatherDashboard());

      // SETTINGS
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.preferences:
        return MaterialPageRoute(builder: (_) => const PreferencesScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                "❌ Unknown route: ${settings.name}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}

// ============================================================================
// SPLASH SCREEN
// ============================================================================
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacementNamed(context, Routes.home);
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.agriculture, size: 72, color: AppColors.primary),
            SizedBox(height: 12),
            Text(
              AppConstants.appName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Serious Farmers — SDG 1 & SDG 2',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
