// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminOrdersHash() => r'64c28f98f38eaea8b2ae53c7c4ee065542487439';

/// See also [adminOrders].
@ProviderFor(adminOrders)
final adminOrdersProvider =
    AutoDisposeStreamProvider<List<OrderEntity>>.internal(
  adminOrders,
  name: r'adminOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$adminOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AdminOrdersRef = AutoDisposeStreamProviderRef<List<OrderEntity>>;
String _$userEmailHash() => r'cd1ceda38693f095f42fbfe4bc2309e07b803ebf';

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

/// See also [userEmail].
@ProviderFor(userEmail)
const userEmailProvider = UserEmailFamily();

/// See also [userEmail].
class UserEmailFamily extends Family<AsyncValue<String>> {
  /// See also [userEmail].
  const UserEmailFamily();

  /// See also [userEmail].
  UserEmailProvider call(
    String userId,
  ) {
    return UserEmailProvider(
      userId,
    );
  }

  @override
  UserEmailProvider getProviderOverride(
    covariant UserEmailProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userEmailProvider';
}

/// See also [userEmail].
class UserEmailProvider extends AutoDisposeFutureProvider<String> {
  /// See also [userEmail].
  UserEmailProvider(
    String userId,
  ) : this._internal(
          (ref) => userEmail(
            ref as UserEmailRef,
            userId,
          ),
          from: userEmailProvider,
          name: r'userEmailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userEmailHash,
          dependencies: UserEmailFamily._dependencies,
          allTransitiveDependencies: UserEmailFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserEmailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<String> Function(UserEmailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserEmailProvider._internal(
        (ref) => create(ref as UserEmailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _UserEmailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserEmailProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserEmailRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserEmailProviderElement extends AutoDisposeFutureProviderElement<String>
    with UserEmailRef {
  _UserEmailProviderElement(super.provider);

  @override
  String get userId => (origin as UserEmailProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
