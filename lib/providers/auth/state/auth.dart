import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthInitial;
  const factory AuthenticationState.loading() = AuthLoading;
  const factory AuthenticationState.success(User? user) = AuthSuccess;
  const factory AuthenticationState.error({String? message}) = AuthError;
}
