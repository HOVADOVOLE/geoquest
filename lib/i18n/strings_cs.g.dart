///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsCs = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.cs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <cs>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// cs: 'GeoQuest'
	String get appName => 'GeoQuest';

	late final TranslationsCommonCs common = TranslationsCommonCs.internal(_root);
	late final TranslationsMainMenuCs mainMenu = TranslationsMainMenuCs.internal(_root);
	late final TranslationsSettingsCs settings = TranslationsSettingsCs.internal(_root);
	late final TranslationsDashboardCs dashboard = TranslationsDashboardCs.internal(_root);
	late final TranslationsRegionsCs regions = TranslationsRegionsCs.internal(_root);
	late final TranslationsGameCs game = TranslationsGameCs.internal(_root);
	late final TranslationsEncyclopediaCs encyclopedia = TranslationsEncyclopediaCs.internal(_root);
	late final TranslationsProfileCs profile = TranslationsProfileCs.internal(_root);
}

// Path: common
class TranslationsCommonCs {
	TranslationsCommonCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Zrušit'
	String get cancel => 'Zrušit';

	/// cs: 'Zpět'
	String get back => 'Zpět';

	/// cs: 'Načítání...'
	String get loading => 'Načítání...';

	/// cs: 'Chyba: $error'
	String error({required Object error}) => 'Chyba: ${error}';

	/// cs: 'mil.'
	String get mil => 'mil.';
}

// Path: mainMenu
class TranslationsMainMenuCs {
	TranslationsMainMenuCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'GeoQuest'
	String get title => 'GeoQuest';

	/// cs: 'Spustit hru'
	String get start => 'Spustit hru';

	/// cs: 'Nastavení'
	String get settings => 'Nastavení';

	/// cs: 'Žebříček'
	String get leaderboard => 'Žebříček';
}

// Path: settings
class TranslationsSettingsCs {
	TranslationsSettingsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Nastavení'
	String get title => 'Nastavení';

	/// cs: 'Jazyk'
	String get language => 'Jazyk';

	/// cs: 'Tmavý režim'
	String get theme => 'Tmavý režim';
}

// Path: dashboard
class TranslationsDashboardCs {
	TranslationsDashboardCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Herní Módy'
	String get gameModes => 'Herní Módy';

	/// cs: 'Lvl $level'
	String level({required Object level}) => 'Lvl ${level}';

	late final TranslationsDashboardCardsCs cards = TranslationsDashboardCardsCs.internal(_root);
	late final TranslationsDashboardRegionDialogCs regionDialog = TranslationsDashboardRegionDialogCs.internal(_root);
}

// Path: regions
class TranslationsRegionsCs {
	TranslationsRegionsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Celý svět'
	String get world => 'Celý svět';

	/// cs: 'Evropa'
	String get europe => 'Evropa';

	/// cs: 'Afrika'
	String get africa => 'Afrika';

	/// cs: 'Amerika'
	String get americas => 'Amerika';

	/// cs: 'Asie'
	String get asia => 'Asie';

	/// cs: 'Austrálie a Oceánie'
	String get oceania => 'Austrálie a Oceánie';
}

// Path: game
class TranslationsGameCs {
	TranslationsGameCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Skóre'
	String get score => 'Skóre';

	/// cs: '${time}s'
	String timer({required Object time}) => '${time}s';

	/// cs: 'Otázka $current / $total'
	String progress({required Object current, required Object total}) => 'Otázka ${current} / ${total}';

	/// cs: 'Jaké zemi patří hlavní město:'
	String get questionCapital => 'Jaké zemi patří hlavní město:';

	/// cs: '???'
	String get unknownCapital => '???';

	/// cs: 'Achievement odemčen!'
	String get achievementUnlocked => 'Achievement odemčen!';

	late final TranslationsGameGameOverCs gameOver = TranslationsGameGameOverCs.internal(_root);
}

// Path: encyclopedia
class TranslationsEncyclopediaCs {
	TranslationsEncyclopediaCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Atlas Zemí'
	String get title => 'Atlas Zemí';

	/// cs: 'Hledat zemi...'
	String get searchPlaceholder => 'Hledat zemi...';

	/// cs: 'Seskupit podle'
	String get groupBy => 'Seskupit podle';

	/// cs: 'Abeceda'
	String get alphabet => 'Abeceda';

	/// cs: 'Kontinent'
	String get continent => 'Kontinent';

	late final TranslationsEncyclopediaDetailCs detail = TranslationsEncyclopediaDetailCs.internal(_root);
}

// Path: profile
class TranslationsProfileCs {
	TranslationsProfileCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Můj Profil'
	String get title => 'Můj Profil';

	/// cs: 'Úroveň $level'
	String level({required Object level}) => 'Úroveň ${level}';

	/// cs: '$xp celkových XP'
	String totalXp({required Object xp}) => '${xp} celkových XP';

	/// cs: 'Hry'
	String get gamesPlayed => 'Hry';

	/// cs: 'Streak'
	String get streak => 'Streak';

	/// cs: 'Achievementy'
	String get achievements => 'Achievementy';

	/// cs: '$count d.'
	String days({required Object count}) => '${count} d.';
}

// Path: dashboard.cards
class TranslationsDashboardCardsCs {
	TranslationsDashboardCardsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDashboardCardsFlagsCs flags = TranslationsDashboardCardsFlagsCs.internal(_root);
	late final TranslationsDashboardCardsCapitalsCs capitals = TranslationsDashboardCardsCapitalsCs.internal(_root);
	late final TranslationsDashboardCardsReverseCs reverse = TranslationsDashboardCardsReverseCs.internal(_root);
	late final TranslationsDashboardCardsRegionsCs regions = TranslationsDashboardCardsRegionsCs.internal(_root);
}

// Path: dashboard.regionDialog
class TranslationsDashboardRegionDialogCs {
	TranslationsDashboardRegionDialogCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Vyber region'
	String get title => 'Vyber region';
}

// Path: game.gameOver
class TranslationsGameGameOverCs {
	TranslationsGameGameOverCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Hra skončila!'
	String get title => 'Hra skončila!';

	/// cs: 'Tvé skóre: $score / $total'
	String scoreText({required Object score, required Object total}) => 'Tvé skóre: ${score} / ${total}';

	/// cs: 'Získáno XP: +$xp'
	String xpEarned({required Object xp}) => 'Získáno XP: +${xp}';

	/// cs: 'Došel ti čas!'
	String get timeOut => 'Došel ti čas!';

	/// cs: 'Zpět do menu'
	String get backToMenu => 'Zpět do menu';
}

// Path: encyclopedia.detail
class TranslationsEncyclopediaDetailCs {
	TranslationsEncyclopediaDetailCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Hlavní město'
	String get capital => 'Hlavní město';

	/// cs: 'Region'
	String get region => 'Region';

	/// cs: 'Populace'
	String get population => 'Populace';

	/// cs: 'Kód (ISO)'
	String get code => 'Kód (ISO)';

	/// cs: 'Zobrazit na mapě'
	String get openMap => 'Zobrazit na mapě';
}

// Path: dashboard.cards.flags
class TranslationsDashboardCardsFlagsCs {
	TranslationsDashboardCardsFlagsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Vlajky Světa'
	String get title => 'Vlajky Světa';

	/// cs: 'Klasický mód'
	String get subtitle => 'Klasický mód';
}

// Path: dashboard.cards.capitals
class TranslationsDashboardCardsCapitalsCs {
	TranslationsDashboardCardsCapitalsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Hlavní Města'
	String get title => 'Hlavní Města';

	/// cs: 'Kdo vládne kde?'
	String get subtitle => 'Kdo vládne kde?';
}

// Path: dashboard.cards.reverse
class TranslationsDashboardCardsReverseCs {
	TranslationsDashboardCardsReverseCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Obrácený Kvíz'
	String get title => 'Obrácený Kvíz';

	/// cs: 'Najdi vlajku'
	String get subtitle => 'Najdi vlajku';
}

// Path: dashboard.cards.regions
class TranslationsDashboardCardsRegionsCs {
	TranslationsDashboardCardsRegionsCs.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// cs: 'Regiony'
	String get title => 'Regiony';

	/// cs: 'Evropa, Asie...'
	String get subtitle => 'Evropa, Asie...';
}

/// The flat map containing all translations for locale <cs>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'GeoQuest',
			'common.cancel' => 'Zrušit',
			'common.back' => 'Zpět',
			'common.loading' => 'Načítání...',
			'common.error' => ({required Object error}) => 'Chyba: ${error}',
			'common.mil' => 'mil.',
			'mainMenu.title' => 'GeoQuest',
			'mainMenu.start' => 'Spustit hru',
			'mainMenu.settings' => 'Nastavení',
			'mainMenu.leaderboard' => 'Žebříček',
			'settings.title' => 'Nastavení',
			'settings.language' => 'Jazyk',
			'settings.theme' => 'Tmavý režim',
			'dashboard.gameModes' => 'Herní Módy',
			'dashboard.level' => ({required Object level}) => 'Lvl ${level}',
			'dashboard.cards.flags.title' => 'Vlajky Světa',
			'dashboard.cards.flags.subtitle' => 'Klasický mód',
			'dashboard.cards.capitals.title' => 'Hlavní Města',
			'dashboard.cards.capitals.subtitle' => 'Kdo vládne kde?',
			'dashboard.cards.reverse.title' => 'Obrácený Kvíz',
			'dashboard.cards.reverse.subtitle' => 'Najdi vlajku',
			'dashboard.cards.regions.title' => 'Regiony',
			'dashboard.cards.regions.subtitle' => 'Evropa, Asie...',
			'dashboard.regionDialog.title' => 'Vyber region',
			'regions.world' => 'Celý svět',
			'regions.europe' => 'Evropa',
			'regions.africa' => 'Afrika',
			'regions.americas' => 'Amerika',
			'regions.asia' => 'Asie',
			'regions.oceania' => 'Austrálie a Oceánie',
			'game.score' => 'Skóre',
			'game.timer' => ({required Object time}) => '${time}s',
			'game.progress' => ({required Object current, required Object total}) => 'Otázka ${current} / ${total}',
			'game.questionCapital' => 'Jaké zemi patří hlavní město:',
			'game.unknownCapital' => '???',
			'game.achievementUnlocked' => 'Achievement odemčen!',
			'game.gameOver.title' => 'Hra skončila!',
			'game.gameOver.scoreText' => ({required Object score, required Object total}) => 'Tvé skóre: ${score} / ${total}',
			'game.gameOver.xpEarned' => ({required Object xp}) => 'Získáno XP: +${xp}',
			'game.gameOver.timeOut' => 'Došel ti čas!',
			'game.gameOver.backToMenu' => 'Zpět do menu',
			'encyclopedia.title' => 'Atlas Zemí',
			'encyclopedia.searchPlaceholder' => 'Hledat zemi...',
			'encyclopedia.groupBy' => 'Seskupit podle',
			'encyclopedia.alphabet' => 'Abeceda',
			'encyclopedia.continent' => 'Kontinent',
			'encyclopedia.detail.capital' => 'Hlavní město',
			'encyclopedia.detail.region' => 'Region',
			'encyclopedia.detail.population' => 'Populace',
			'encyclopedia.detail.code' => 'Kód (ISO)',
			'encyclopedia.detail.openMap' => 'Zobrazit na mapě',
			'profile.title' => 'Můj Profil',
			'profile.level' => ({required Object level}) => 'Úroveň ${level}',
			'profile.totalXp' => ({required Object xp}) => '${xp} celkových XP',
			'profile.gamesPlayed' => 'Hry',
			'profile.streak' => 'Streak',
			'profile.achievements' => 'Achievementy',
			'profile.days' => ({required Object count}) => '${count} d.',
			_ => null,
		};
	}
}
