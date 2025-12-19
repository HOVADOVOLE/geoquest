// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countriesRepositoryHash() =>
    r'3c07f573f1851c4baad5b3bf1c46a50ea2a9b82f';

/// Repozitář pro získávání dat o zemích z API s podporou lokální cache.
///
/// Copied from [CountriesRepository].
@ProviderFor(CountriesRepository)
final countriesRepositoryProvider = AutoDisposeAsyncNotifierProvider<
    CountriesRepository, List<Country>>.internal(
  CountriesRepository.new,
  name: r'countriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$countriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CountriesRepository = AutoDisposeAsyncNotifier<List<Country>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
