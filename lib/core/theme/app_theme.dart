import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Třída definující vizuální styl aplikace GeoQuest.
///
/// **Účel:**
/// Poskytuje centralizovanou konfiguraci témat (světlý/tmavý režim) pro celou aplikaci.
/// Využívá balíček `shadcn_ui` pro moderní vzhled.
class AppTheme {
  
  /// Vytvoří a vrátí konfiguraci pro světlý režim (Light Mode).
  ///
  /// **Co dělá:**
  /// Nastavuje `brightness` na `light` a aplikuje barevné schéma `ShadZincColorScheme.light`.
  ///
  /// **Vstupní parametry:**
  /// - `context`: BuildContext (aktuálně nevyužit, ale připraven pro budoucí potřeby, např. MediaQuery).
  ///
  /// **Výstupní parametry:**
  /// - `ShadThemeData`: Objekt obsahující kompletní definici stylu pro světlý režim.
  ///
  /// **Interní logika:**
  /// Vrací instanci `ShadThemeData` s předdefinovaným zinkovým schématem.
  static ShadThemeData light(BuildContext context) {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadZincColorScheme.light(),
      // Zde můžeme přepsat fonty nebo specifické komponenty
    );
  }

  /// Vytvoří a vrátí konfiguraci pro tmavý režim (Dark Mode).
  ///
  /// **Co dělá:**
  /// Nastavuje `brightness` na `dark` a aplikuje barevné schéma `ShadZincColorScheme.dark`.
  ///
  /// **Vstupní parametry:**
  /// - `context`: BuildContext.
  ///
  /// **Výstupní parametry:**
  /// - `ShadThemeData`: Objekt obsahující kompletní definici stylu pro tmavý režim.
  ///
  /// **Interní logika:**
  /// Vrací instanci `ShadThemeData` s předdefinovaným tmavým zinkovým schématem.
  static ShadThemeData dark(BuildContext context) {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadZincColorScheme.dark(),
    );
  }
}
