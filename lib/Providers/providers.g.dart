// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDeliveryNoteHash() => r'99cb7e0e85f79eec1d6089882ca0c84b3a1f957a';

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

/// See also [getDeliveryNote].
@ProviderFor(getDeliveryNote)
const getDeliveryNoteProvider = GetDeliveryNoteFamily();

/// See also [getDeliveryNote].
class GetDeliveryNoteFamily extends Family<AsyncValue<dynamic>> {
  /// See also [getDeliveryNote].
  const GetDeliveryNoteFamily();

  /// See also [getDeliveryNote].
  GetDeliveryNoteProvider call({
    required String staff_id,
    required String client_id,
  }) {
    return GetDeliveryNoteProvider(
      staff_id: staff_id,
      client_id: client_id,
    );
  }

  @override
  GetDeliveryNoteProvider getProviderOverride(
    covariant GetDeliveryNoteProvider provider,
  ) {
    return call(
      staff_id: provider.staff_id,
      client_id: provider.client_id,
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
  String? get name => r'getDeliveryNoteProvider';
}

/// See also [getDeliveryNote].
class GetDeliveryNoteProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [getDeliveryNote].
  GetDeliveryNoteProvider({
    required String staff_id,
    required String client_id,
  }) : this._internal(
          (ref) => getDeliveryNote(
            ref as GetDeliveryNoteRef,
            staff_id: staff_id,
            client_id: client_id,
          ),
          from: getDeliveryNoteProvider,
          name: r'getDeliveryNoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDeliveryNoteHash,
          dependencies: GetDeliveryNoteFamily._dependencies,
          allTransitiveDependencies:
              GetDeliveryNoteFamily._allTransitiveDependencies,
          staff_id: staff_id,
          client_id: client_id,
        );

  GetDeliveryNoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.staff_id,
    required this.client_id,
  }) : super.internal();

  final String staff_id;
  final String client_id;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(GetDeliveryNoteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDeliveryNoteProvider._internal(
        (ref) => create(ref as GetDeliveryNoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        staff_id: staff_id,
        client_id: client_id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _GetDeliveryNoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDeliveryNoteProvider &&
        other.staff_id == staff_id &&
        other.client_id == client_id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, staff_id.hashCode);
    hash = _SystemHash.combine(hash, client_id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDeliveryNoteRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `staff_id` of this provider.
  String get staff_id;

  /// The parameter `client_id` of this provider.
  String get client_id;
}

class _GetDeliveryNoteProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with GetDeliveryNoteRef {
  _GetDeliveryNoteProviderElement(super.provider);

  @override
  String get staff_id => (origin as GetDeliveryNoteProvider).staff_id;
  @override
  String get client_id => (origin as GetDeliveryNoteProvider).client_id;
}

String _$loginStaffHash() => r'a18cbae3c70c18d2a9ac8678ebada4c014fd29a5';

/// See also [loginStaff].
@ProviderFor(loginStaff)
const loginStaffProvider = LoginStaffFamily();

/// See also [loginStaff].
class LoginStaffFamily extends Family<AsyncValue<dynamic>> {
  /// See also [loginStaff].
  const LoginStaffFamily();

  /// See also [loginStaff].
  LoginStaffProvider call({
    required String email,
    required String password,
  }) {
    return LoginStaffProvider(
      email: email,
      password: password,
    );
  }

  @override
  LoginStaffProvider getProviderOverride(
    covariant LoginStaffProvider provider,
  ) {
    return call(
      email: provider.email,
      password: provider.password,
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
  String? get name => r'loginStaffProvider';
}

/// See also [loginStaff].
class LoginStaffProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [loginStaff].
  LoginStaffProvider({
    required String email,
    required String password,
  }) : this._internal(
          (ref) => loginStaff(
            ref as LoginStaffRef,
            email: email,
            password: password,
          ),
          from: loginStaffProvider,
          name: r'loginStaffProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginStaffHash,
          dependencies: LoginStaffFamily._dependencies,
          allTransitiveDependencies:
              LoginStaffFamily._allTransitiveDependencies,
          email: email,
          password: password,
        );

  LoginStaffProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.password,
  }) : super.internal();

  final String email;
  final String password;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(LoginStaffRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginStaffProvider._internal(
        (ref) => create(ref as LoginStaffRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        password: password,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _LoginStaffProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginStaffProvider &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginStaffRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;
}

class _LoginStaffProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with LoginStaffRef {
  _LoginStaffProviderElement(super.provider);

  @override
  String get email => (origin as LoginStaffProvider).email;
  @override
  String get password => (origin as LoginStaffProvider).password;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
