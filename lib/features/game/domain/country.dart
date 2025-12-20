import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'country.g.dart';

/// Model reprezentující zemi z REST Countries API.
@JsonSerializable()
@HiveType(typeId: 0)
class Country {
  @HiveField(0)
  final CountryName name;
  @HiveField(1)
  final String cca3;
  @HiveField(2)
  final CountryFlags flags;
  @HiveField(3)
  final String region;
  @HiveField(4)
  final Map<String, Translation> translations;
  @HiveField(5)
  final List<String>? capital;
  @HiveField(6, defaultValue: 0)
  final int population;
  @HiveField(7, defaultValue: const [])
  final List<String> continents;
  @HiveField(8)
  final CountryMaps maps;

  Country({
    required this.name,
    required this.cca3,
    required this.flags,
    required this.region,
    required this.translations,
    this.capital,
    this.population = 0,
    this.continents = const [],
    required this.maps,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 1)
class CountryName {
  @HiveField(0)
  final String common;
  @HiveField(1)
  final String official;

  CountryName({required this.common, required this.official});

  factory CountryName.fromJson(Map<String, dynamic> json) => _$CountryNameFromJson(json);
  Map<String, dynamic> toJson() => _$CountryNameToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 2)
class CountryFlags {
  @HiveField(0)
  final String png;
  @HiveField(1)
  final String svg;
  @HiveField(2)
  final String? alt;

  CountryFlags({required this.png, required this.svg, this.alt});

  factory CountryFlags.fromJson(Map<String, dynamic> json) => _$CountryFlagsFromJson(json);
  Map<String, dynamic> toJson() => _$CountryFlagsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 3)
class Translation {
  @HiveField(0)
  final String official;
  @HiveField(1)
  final String common;

  Translation({required this.official, required this.common});

  factory Translation.fromJson(Map<String, dynamic> json) => _$TranslationFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 5)
class CountryMaps {
  @HiveField(0)
  final String googleMaps;
  @HiveField(1)
  final String? openStreetMaps;

  CountryMaps({required this.googleMaps, this.openStreetMaps});

  factory CountryMaps.fromJson(Map<String, dynamic> json) => _$CountryMapsFromJson(json);
  Map<String, dynamic> toJson() => _$CountryMapsToJson(this);
}