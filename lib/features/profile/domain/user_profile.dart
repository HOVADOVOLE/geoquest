import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 6)
class UserProfile {
  @HiveField(0)
  final int totalXp;

  @HiveField(1)
  final int currentLevel;

  @HiveField(2)
  final int gamesPlayed;

  @HiveField(3)
  final int streakDays;

  @HiveField(4)
  final DateTime? lastPlayed;

  const UserProfile({
    this.totalXp = 0,
    this.currentLevel = 1,
    this.gamesPlayed = 0,
    this.streakDays = 0,
    this.lastPlayed,
  });

  UserProfile copyWith({
    int? totalXp,
    int? currentLevel,
    int? gamesPlayed,
    int? streakDays,
    DateTime? lastPlayed,
  }) {
    return UserProfile(
      totalXp: totalXp ?? this.totalXp,
      currentLevel: currentLevel ?? this.currentLevel,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      streakDays: streakDays ?? this.streakDays,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }
  
  /// Vypočítá XP potřebné pro další level.
  /// Formule: Level * 200 XP.
  /// Level 1 -> 200 XP
  /// Level 2 -> 400 XP
  int get xpForNextLevel => currentLevel * 200;

  /// Vypočítá progress pro progress bar (0.0 až 1.0).
  /// Musíme odečíst XP akumulované pro předchozí levely, abychom měli progress v rámci aktuálního levelu.
  double get levelProgress {
    // Zjednodušená logika pro MVP:
    // Předpokládáme, že totalXp se resetuje nebo počítáme modulo.
    // Ale lepší je držet totalXp "navždy" a vypočítat aktuální stav.
    
    // Pro jednoduchost: Progress v rámci levelu je: (totalXp % xpForNextLevel) / xpForNextLevel
    // To není matematicky přesné pro RPG (kde se nároky zvyšují), ale pro vizualizaci stačí.
    
    // Lepší přístup:
    int xpInCurrentLevel = totalXp;
    for (int i = 1; i < currentLevel; i++) {
      xpInCurrentLevel -= (i * 200);
    }
    
    double progress = xpInCurrentLevel / xpForNextLevel;
    return progress.clamp(0.0, 1.0);
  }
}
