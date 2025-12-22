import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main_scaffold.dart';

/// Úvodní obrazovka aplikace (Splash Screen).
///
/// **Účel:**
/// Zobrazí logo a načítá potřebná data (inicializace).
/// Obsahuje patičku s autorem ("Made by...").
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Inicializuje aplikaci a po prodlevě přejde na hlavní obrazovku.
  Future<void> _initializeApp() async {
    // Simulace minimálního zobrazení loga (aby jen neprobliklo)
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Centrální obsah (Logo + Název)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.public, 
                  size: 100.w, 
                  color: ShadTheme.of(context).colorScheme.primary
                ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                SizedBox(height: 20.h),
                Text(
                  'GeoQuest',
                  style: ShadTheme.of(context).textTheme.h1Large,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                SizedBox(height: 30.h),
                const CircularProgressIndicator()
                    .animate()
                    .fadeIn(delay: 500.ms),
              ],
            ),
          ),
          
          // Patička (Made by)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Made by',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Dominik Vinš',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: ShadTheme.of(context).colorScheme.foreground,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms).slideY(begin: 1, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}