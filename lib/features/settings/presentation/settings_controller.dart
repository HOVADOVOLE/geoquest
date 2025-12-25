import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import '../../../core/database/hive_service.dart';

part 'settings_controller.g.dart';

/// Kontroler pro správu nastavení (např. tmavý režim).
@riverpod
class SettingsController extends _$SettingsController {
  late final Box _box;

  @override
  bool build() {
    _box = Hive.box(HiveService.settingsBoxName);
    return _box.get('darkMode', defaultValue: false);
  }

  /// Přepne tmavý režim a uloží nastavení do Hive.
  void toggleDarkMode() {
    final newValue = !state;
    state = newValue;
    _box.put('darkMode', newValue);
  }
}
