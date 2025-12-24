import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../game/domain/country.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  Future<void> _openMap() async {
    final url = Uri.parse(country.maps.googleMaps);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.translations['ces']?.common ?? country.name.common),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Vlajka
            AspectRatio(
              aspectRatio: 5 / 3,
              child: ShadCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.network(
                    country.flags.svg,
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Základní info
            ShadCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow(
                      'Hlavní město',
                      country.capital?.join(', ') ?? 'N/A',
                      LucideIcons.building2,
                    ),
                    const Divider(),
                    _buildInfoRow('Region', country.region, LucideIcons.globe),
                    const Divider(),
                    _buildInfoRow(
                      'Populace',
                      _formatPopulation(country.population),
                      LucideIcons.users,
                    ),
                    const Divider(),
                    _buildInfoRow('Kód (ISO)', country.cca3, LucideIcons.hash),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tlačítko na mapu
            ShadButton.outline(
              width: double.infinity,
              onPressed: _openMap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.map, size: 16),
                  SizedBox(width: 8),
                  Text('Zobrazit na mapě'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatPopulation(int population) {
    if (population > 1000000) {
      return '${(population / 1000000).toStringAsFixed(1)} mil.';
    }
    return population.toString();
  }
}
