import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/database/hive_service.dart';
import 'features/settings/presentation/settings_controller.dart';
import 'i18n/strings.g.dart';
import 'features/home/presentation/splash_screen.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializace Hive
  await HiveService.init();
  
  runApp(
    TranslationProvider(
      child: const ProviderScope(
        child: GeoQuestApp(),
      ),
    ),
  );
}

class GeoQuestApp extends ConsumerWidget {
  const GeoQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsControllerProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ShadApp(
          debugShowCheckedModeBanner: false,
          title: 'GeoQuest',
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light(context),
          darkTheme: AppTheme.dark(context),
          home: const SplashScreen(),
        );
      },
    );
  }
}
