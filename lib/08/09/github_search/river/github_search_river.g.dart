// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_search_river.dart';

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
String _$githubSearchRiverHash() => r'3d07908c2843c39149c3c6b02c6b380cc0592d47';

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

/// See also [githubSearchRiver].
@ProviderFor(githubSearchRiver)
const githubSearchRiverProvider = GithubSearchRiverFamily();

/// See also [githubSearchRiver].
class GithubSearchRiverFamily extends Family<AsyncValue<GithubSearchResult>> {
  /// See also [githubSearchRiver].
  const GithubSearchRiverFamily();

  /// See also [githubSearchRiver].
  GithubSearchRiverProvider call({
    String args = '',
  }) {
    return GithubSearchRiverProvider(
      args: args,
    );
  }

  @override
  GithubSearchRiverProvider getProviderOverride(
    covariant GithubSearchRiverProvider provider,
  ) {
    return call(
      args: provider.args,
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
  String? get name => r'githubSearchRiverProvider';
}

/// See also [githubSearchRiver].
class GithubSearchRiverProvider
    extends AutoDisposeFutureProvider<GithubSearchResult> {
  /// See also [githubSearchRiver].
  GithubSearchRiverProvider({
    String args = '',
  }) : this._internal(
          (ref) => githubSearchRiver(
            ref as GithubSearchRiverRef,
            args: args,
          ),
          from: githubSearchRiverProvider,
          name: r'githubSearchRiverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$githubSearchRiverHash,
          dependencies: GithubSearchRiverFamily._dependencies,
          allTransitiveDependencies:
              GithubSearchRiverFamily._allTransitiveDependencies,
          args: args,
        );

  GithubSearchRiverProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final String args;

  @override
  Override overrideWith(
    FutureOr<GithubSearchResult> Function(GithubSearchRiverRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GithubSearchRiverProvider._internal(
        (ref) => create(ref as GithubSearchRiverRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GithubSearchResult> createElement() {
    return _GithubSearchRiverProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GithubSearchRiverProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GithubSearchRiverRef on AutoDisposeFutureProviderRef<GithubSearchResult> {
  /// The parameter `args` of this provider.
  String get args;
}

class _GithubSearchRiverProviderElement
    extends AutoDisposeFutureProviderElement<GithubSearchResult>
    with GithubSearchRiverRef {
  _GithubSearchRiverProviderElement(super.provider);

  @override
  String get args => (origin as GithubSearchRiverProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
