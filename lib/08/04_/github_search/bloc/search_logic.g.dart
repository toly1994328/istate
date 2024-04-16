// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_logic.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$githubRepositoryHash() => r'fdb7095efea5c3b4b692646b11e92821a25cd8a0';

/// See also [githubRepository].
@ProviderFor(githubRepository)
final githubRepositoryProvider = AutoDisposeProvider<GithubRepository>.internal(
  githubRepository,
  name: r'githubRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$githubRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GithubRepositoryRef = AutoDisposeProviderRef<GithubRepository>;
String _$githubSearchHash() => r'ed276db8542b66b89fd96f94cf86f0efe05fc392';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [githubSearch].
@ProviderFor(githubSearch)
const githubSearchProvider = GithubSearchFamily();

/// See also [githubSearch].
class GithubSearchFamily extends Family<AsyncValue<List<RepositoryInfo>>> {
  /// See also [githubSearch].
  const GithubSearchFamily();

  /// See also [githubSearch].
  GithubSearchProvider call({
    String search = '',
  }) {
    return GithubSearchProvider(
      search: search,
    );
  }

  @override
  GithubSearchProvider getProviderOverride(
    covariant GithubSearchProvider provider,
  ) {
    return call(
      search: provider.search,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'githubSearchProvider';
}

/// See also [githubSearch].
class GithubSearchProvider
    extends AutoDisposeFutureProvider<List<RepositoryInfo>> {
  /// See also [githubSearch].
  GithubSearchProvider({
    String search = '',
  }) : this._internal(
          (ref) => githubSearch(
            ref as GithubSearchRef,
            search: search,
          ),
          from: githubSearchProvider,
          name: r'githubSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$githubSearchHash,
          dependencies: GithubSearchFamily._dependencies,
          allTransitiveDependencies:
              GithubSearchFamily._allTransitiveDependencies,
          search: search,
        );

  GithubSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
  }) : super.internal();

  final String search;

  @override
  Override overrideWith(
    FutureOr<List<RepositoryInfo>> Function(GithubSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GithubSearchProvider._internal(
        (ref) => create(ref as GithubSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RepositoryInfo>> createElement() {
    return _GithubSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GithubSearchProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GithubSearchRef on AutoDisposeFutureProviderRef<List<RepositoryInfo>> {
  /// The parameter `search` of this provider.
  String get search;
}

class _GithubSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<RepositoryInfo>>
    with GithubSearchRef {
  _GithubSearchProviderElement(super.provider);

  @override
  String get search => (origin as GithubSearchProvider).search;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
