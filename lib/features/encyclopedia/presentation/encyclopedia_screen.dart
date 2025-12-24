import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../i18n/strings.g.dart';
import '../../game/data/countries_repository.dart';
import '../../game/domain/country.dart';
import 'country_detail_screen.dart';

/// Enum pro možnosti seskupování.
enum GroupBy { alphabet, continent }

/// Abstraktní třída pro položky v seznamu (hlavička nebo země).
abstract class EncyclopediaItem {}

class HeaderItem extends EncyclopediaItem {
  final String title;
  HeaderItem(this.title);
}

class CountryItem extends EncyclopediaItem {
  final Country country;
  CountryItem(this.country);
}

/// Obrazovka encyklopedie (Atlasu).
///
/// **Účel:**
/// Zobrazuje seznam všech zemí s možností vyhledávání a seskupování (abeceda, kontinenty).
/// Po kliknutí na zemi otevře detailní informace.
class EncyclopediaScreen extends ConsumerStatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  ConsumerState<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends ConsumerState<EncyclopediaScreen> {
  String _searchQuery = '';
  List<Country> _allCountries = [];
  GroupBy _groupBy = GroupBy.alphabet;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Načte data o zemích.
  ///
  /// **Co dělá:**
  /// Asynchronně získá seznam zemí z repozitáře.
  Future<void> _loadData() async {
    final countries = await ref
        .read(countriesRepositoryProvider.notifier)
        .getCountries();
    if (mounted) {
      setState(() {
        _allCountries = countries;
      });
    }
  }

  /// Generuje seznam položek (hlavičky + země) podle aktuálního seskupení.
  List<EncyclopediaItem> _generateItems(List<Country> countries, Translations t) {
    final items = <EncyclopediaItem>[];
    if (countries.isEmpty) return items;

    if (_groupBy == GroupBy.alphabet) {
      // Seřadit abecedně
      countries.sort((a, b) {
        final nameA = a.translations['ces']?.common ?? a.name.common;
        final nameB = b.translations['ces']?.common ?? b.name.common;
        return nameA.compareTo(nameB);
      });

      String? lastLetter;
      for (var country in countries) {
        final name = country.translations['ces']?.common ?? country.name.common;
        final letter = name.isNotEmpty ? name[0].toUpperCase() : '#';
        
        if (letter != lastLetter) {
          items.add(HeaderItem(letter));
          lastLetter = letter;
        }
        items.add(CountryItem(country));
      }
    } else {
      // Seřadit podle regionu
      countries.sort((a, b) => a.region.compareTo(b.region));

      String? lastRegion;
      for (var country in countries) {
        // Tady bychom mohli použít lokalizované názvy regionů, pokud bychom je měli mapované
        // Pro zjednodušení použijeme hodnotu z API (EN), nebo mapování pokud existuje
        final region = country.region; 
        
        if (region != lastRegion) {
          items.add(HeaderItem(region));
          lastRegion = region;
        }
        items.add(CountryItem(country));
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final filteredCountries = _allCountries.where((country) {
      final name = country.translations['ces']?.common ?? country.name.common;
      return name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final items = _generateItems(filteredCountries, t);

    return Scaffold(
      appBar: AppBar(title: Text(t.encyclopedia.title)),
      body: Column(
        children: [
          // Ovládací prvky (Search + Grouping)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ShadInput(
                  placeholder: Text(t.encyclopedia.searchPlaceholder),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('${t.encyclopedia.groupBy}: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    _groupBy == GroupBy.alphabet
                        ? ShadButton(
                            size: ShadButtonSize.sm,
                            onPressed: () => setState(() => _groupBy = GroupBy.alphabet),
                            child: Text(t.encyclopedia.alphabet),
                          )
                        : ShadButton.outline(
                            size: ShadButtonSize.sm,
                            onPressed: () => setState(() => _groupBy = GroupBy.alphabet),
                            child: Text(t.encyclopedia.alphabet),
                          ),
                    const SizedBox(width: 8),
                    _groupBy == GroupBy.continent
                        ? ShadButton(
                            size: ShadButtonSize.sm,
                            onPressed: () => setState(() => _groupBy = GroupBy.continent),
                            child: Text(t.encyclopedia.continent),
                          )
                        : ShadButton.outline(
                            size: ShadButtonSize.sm,
                            onPressed: () => setState(() => _groupBy = GroupBy.continent),
                            child: Text(t.encyclopedia.continent),
                          ),
                  ],
                ),
              ],
            ),
          ),
          
          // Seznam
          Expanded(
            child: _allCountries.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      if (item is HeaderItem) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: ShadTheme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
                          child: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      } else if (item is CountryItem) {
                        final country = item.country;
                        final name = country.translations['ces']?.common ?? country.name.common;

                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SvgPicture.network(
                                country.flags.svg,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(name),
                          subtitle: Text(country.region),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CountryDetailScreen(country: country),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
