// Mocks generated by Mockito 5.4.4 from annotations
// in app_frotas/test/auth/domain/usecases/login_driver_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart' as _i2;
import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDriver_0 extends _i1.SmartFake implements _i2.Driver {
  _FakeDriver_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Driver> login(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            username,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Driver>.value(_FakeDriver_0(
          this,
          Invocation.method(
            #login,
            [
              username,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Driver>);

  @override
  _i4.Future<dynamic> refreshToken() => (super.noSuchMethod(
        Invocation.method(
          #refreshToken,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}