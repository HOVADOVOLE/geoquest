import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import '../../../core/database/hive_service.dart';
import '../domain/user_profile.dart';

part 'user_profile_controller.g.dart';

@riverpod
class UserProfileController extends _$UserProfileController {
  late Box<UserProfile> _box;
  static const String _key = 'user_profile';

  @override
  UserProfile build() {
    _box = Hive.box<UserProfile>(HiveService.userProfileBoxName);
    return _box.get(_key) ?? const UserProfile();
  }

  /// Přidá XP a přepočítá level.
  void addExperience(int xp) {
    final oldProfile = state;
    int newTotalXp = oldProfile.totalXp + xp;
    int currentLevel = oldProfile.currentLevel;
    int gamesPlayed = oldProfile.gamesPlayed + 1;
    
    // Level Up Logika
    // XP potřebné pro dokončení levelu L: L * 200.
    // Celkové XP pro dosažení levelu L+1: součet řady.
    // Pro zjednodušení: kontrolujeme, zda XP v aktuálním levelu nepřeteklo.
    
    int xpRequired = currentLevel * 200;
    
    // Kolik XP už jsme "utratili" za předchozí levely?
    int xpSpent = 0;
    for (int i = 1; i < currentLevel; i++) {
      xpSpent += i * 200;
    }
    
    int xpInCurrentLevel = newTotalXp - xpSpent;
    
    while (xpInCurrentLevel >= xpRequired) {
      xpInCurrentLevel -= xpRequired;
      xpSpent += xpRequired;
      currentLevel++;
      xpRequired = currentLevel * 200;
      // Zde bychom mohli notifikovat UI o Level UPU
    }

    final newProfile = oldProfile.copyWith(
      totalXp: newTotalXp,
      currentLevel: currentLevel,
      gamesPlayed: gamesPlayed,
      lastPlayed: DateTime.now(),
    );

    _box.put(_key, newProfile);
    state = newProfile;
  }
}
