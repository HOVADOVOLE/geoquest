// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 0;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      name: fields[0] as CountryName,
      cca3: fields[1] as String,
      flags: fields[2] as CountryFlags,
      region: fields[3] as String,
      translations: (fields[4] as Map).cast<String, Translation>(),
      capital: (fields[5] as List?)?.cast<String>(),
      population: fields[6] == null ? 0 : fields[6] as int,
      continents: fields[7] == null ? [] : (fields[7] as List).cast<String>(),
      maps: fields[8] as CountryMaps,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cca3)
      ..writeByte(2)
      ..write(obj.flags)
      ..writeByte(3)
      ..write(obj.region)
      ..writeByte(4)
      ..write(obj.translations)
      ..writeByte(5)
      ..write(obj.capital)
      ..writeByte(6)
      ..write(obj.population)
      ..writeByte(7)
      ..write(obj.continents)
      ..writeByte(8)
      ..write(obj.maps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryNameAdapter extends TypeAdapter<CountryName> {
  @override
  final int typeId = 1;

  @override
  CountryName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryName(
      common: fields[0] as String,
      official: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountryName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.common)
      ..writeByte(1)
      ..write(obj.official);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryFlagsAdapter extends TypeAdapter<CountryFlags> {
  @override
  final int typeId = 2;

  @override
  CountryFlags read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryFlags(
      png: fields[0] as String,
      svg: fields[1] as String,
      alt: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryFlags obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.png)
      ..writeByte(1)
      ..write(obj.svg)
      ..writeByte(2)
      ..write(obj.alt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryFlagsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TranslationAdapter extends TypeAdapter<Translation> {
  @override
  final int typeId = 3;

  @override
  Translation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Translation(
      official: fields[0] as String,
      common: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Translation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.official)
      ..writeByte(1)
      ..write(obj.common);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryMapsAdapter extends TypeAdapter<CountryMaps> {
  @override
  final int typeId = 5;

  @override
  CountryMaps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryMaps(
      googleMaps: fields[0] as String,
      openStreetMaps: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryMaps obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.googleMaps)
      ..writeByte(1)
      ..write(obj.openStreetMaps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryMapsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: CountryName.fromJson(json['name'] as Map<String, dynamic>),
      cca3: json['cca3'] as String,
      flags: CountryFlags.fromJson(json['flags'] as Map<String, dynamic>),
      region: json['region'] as String,
      translations: (json['translations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Translation.fromJson(e as Map<String, dynamic>)),
      ),
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      population: (json['population'] as num?)?.toInt() ?? 0,
      continents: (json['continents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maps: CountryMaps.fromJson(json['maps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'cca3': instance.cca3,
      'flags': instance.flags,
      'region': instance.region,
      'translations': instance.translations,
      'capital': instance.capital,
      'population': instance.population,
      'continents': instance.continents,
      'maps': instance.maps,
    };

CountryName _$CountryNameFromJson(Map<String, dynamic> json) => CountryName(
      common: json['common'] as String,
      official: json['official'] as String,
    );

Map<String, dynamic> _$CountryNameToJson(CountryName instance) =>
    <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
    };

CountryFlags _$CountryFlagsFromJson(Map<String, dynamic> json) => CountryFlags(
      png: json['png'] as String,
      svg: json['svg'] as String,
      alt: json['alt'] as String?,
    );

Map<String, dynamic> _$CountryFlagsToJson(CountryFlags instance) =>
    <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
      'alt': instance.alt,
    };

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      official: json['official'] as String,
      common: json['common'] as String,
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'official': instance.official,
      'common': instance.common,
    };

CountryMaps _$CountryMapsFromJson(Map<String, dynamic> json) => CountryMaps(
      googleMaps: json['googleMaps'] as String,
      openStreetMaps: json['openStreetMaps'] as String?,
    );

Map<String, dynamic> _$CountryMapsToJson(CountryMaps instance) =>
    <String, dynamic>{
      'googleMaps': instance.googleMaps,
      'openStreetMaps': instance.openStreetMaps,
    };
