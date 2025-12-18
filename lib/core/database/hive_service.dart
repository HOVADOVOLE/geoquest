import 'package:hive_flutter/hive_flutter.dart';
import '../../features/game/domain/country.dart';
import '../../features/game/domain/leaderboard_entry.dart';
import '../../features/profile/domain/user_profile.dart';
import '../../features/profile/domain/achievement.dart';

/// Služba pro inicializaci a správu lokální databáze Hive.
class HiveService {
  static const String countriesBoxName = 'countriesBox';
  static const String settingsBoxName = 'settingsBox';
  static const String leaderboardBoxName = 'leaderboardBox';
  static const String userProfileBoxName = 'userProfileBox';
  static const String achievementsBoxName = 'achievementsBox';
  
  // Zvýšením tohoto čísla vynutíme smazání cache zemí
  static const int _currentDataVersion = 1;

  /// Inicializuje Hive a zaregistruje adaptéry.
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Registrace adaptérů pro modely
    Hive.registerAdapter(CountryAdapter());
    Hive.registerAdapter(CountryNameAdapter());
    Hive.registerAdapter(CountryFlagsAdapter());
    Hive.registerAdapter(TranslationAdapter());
    Hive.registerAdapter(LeaderboardEntryAdapter());
    Hive.registerAdapter(CountryMapsAdapter());
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(AchievementAdapter());

    // Otevření boxů s ošetřením chyb (migrace)
    try {
      await Hive.openBox<Country>(countriesBoxName);
      await Hive.openBox(settingsBoxName);
      await Hive.openBox<LeaderboardEntry>(leaderboardBoxName);
      await Hive.openBox<UserProfile>(userProfileBoxName);
      await Hive.openBox<Achievement>(achievementsBoxName);
    } catch (e) {
      print('HiveService: Error opening boxes ($e). Deleting all boxes and restarting...');
      
      await _safeDeleteBox(countriesBoxName);
      await _safeDeleteBox(settingsBoxName);
      await _safeDeleteBox(leaderboardBoxName);
      await _safeDeleteBox(userProfileBoxName);
      await _safeDeleteBox(achievementsBoxName);
      
      // Zkusit znovu otevřít
      await Hive.openBox<Country>(countriesBoxName);
      await Hive.openBox(settingsBoxName);
      await Hive.openBox<LeaderboardEntry>(leaderboardBoxName);
      await Hive.openBox<UserProfile>(userProfileBoxName);
      await Hive.openBox<Achievement>(achievementsBoxName);
    }

    await _checkDataMigration();
  }

  static Future<void> _safeDeleteBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      print('HiveService: Failed to delete box $boxName: $e');
    }
  }

  /// Zkontroluje verzi dat a případně promaže cache.
  static Future<void> _checkDataMigration() async {
    final settingsBox = Hive.box(settingsBoxName);
    final savedVersion = settingsBox.get('dataVersion', defaultValue: 0) as int;

    if (savedVersion < _currentDataVersion) {
      print('HiveService: Migrating data from v$savedVersion to v$_currentDataVersion...');
      final countriesBox = Hive.box<Country>(countriesBoxName);
      await countriesBox.clear();
      await settingsBox.put('dataVersion', _currentDataVersion);
      print('HiveService: Countries cache cleared.');
    }
  }
}