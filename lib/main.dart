import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App
import 'app.dart';

// Local Services
import 'services/supabase_service.dart';

// Providers
import 'providers/auth_provider.dart';
import 'providers/farm_provider.dart';
import 'providers/crop_provider.dart';
import 'providers/marketplace_provider.dart';
import 'providers/training_provider.dart';
import 'providers/weather_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely read environment variables
  const supaUrl = String.fromEnvironment('SUPABASE_URL');
  const supaKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  if (supaUrl.isEmpty || supaKey.isEmpty) {
    throw Exception(
      '❌ Missing env variables.\n'
      'Run your app with:\n\n'
      'flutter run --dart-define=SUPABASE_URL=xxx '
      '--dart-define=SUPABASE_ANON_KEY=xxx\n',
    );
  }

  await SupabaseService().init(url: supaUrl, anonKey: supaKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FarmProvider()),
        ChangeNotifierProvider(create: (_) => CropProvider()),
        ChangeNotifierProvider(create: (_) => MarketplaceProvider()),
        ChangeNotifierProvider(create: (_) => TrainingProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const RootApp(),
    ),
  );
}
