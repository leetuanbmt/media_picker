// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GlobalSetting {
  Color? get themeColor => throw _privateConstructorUsedError;
  String? get fontFamily => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GlobalSettingCopyWith<GlobalSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalSettingCopyWith<$Res> {
  factory $GlobalSettingCopyWith(
          GlobalSetting value, $Res Function(GlobalSetting) then) =
      _$GlobalSettingCopyWithImpl<$Res, GlobalSetting>;
  @useResult
  $Res call({Color? themeColor, String? fontFamily});
}

/// @nodoc
class _$GlobalSettingCopyWithImpl<$Res, $Val extends GlobalSetting>
    implements $GlobalSettingCopyWith<$Res> {
  _$GlobalSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeColor = freezed,
    Object? fontFamily = freezed,
  }) {
    return _then(_value.copyWith(
      themeColor: freezed == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GlobalSettingImplCopyWith<$Res>
    implements $GlobalSettingCopyWith<$Res> {
  factory _$$GlobalSettingImplCopyWith(
          _$GlobalSettingImpl value, $Res Function(_$GlobalSettingImpl) then) =
      __$$GlobalSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color? themeColor, String? fontFamily});
}

/// @nodoc
class __$$GlobalSettingImplCopyWithImpl<$Res>
    extends _$GlobalSettingCopyWithImpl<$Res, _$GlobalSettingImpl>
    implements _$$GlobalSettingImplCopyWith<$Res> {
  __$$GlobalSettingImplCopyWithImpl(
      _$GlobalSettingImpl _value, $Res Function(_$GlobalSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeColor = freezed,
    Object? fontFamily = freezed,
  }) {
    return _then(_$GlobalSettingImpl(
      themeColor: freezed == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GlobalSettingImpl implements _GlobalSetting {
  const _$GlobalSettingImpl({this.themeColor, this.fontFamily});

  @override
  final Color? themeColor;
  @override
  final String? fontFamily;

  @override
  String toString() {
    return 'GlobalSetting(themeColor: $themeColor, fontFamily: $fontFamily)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlobalSettingImpl &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeColor, fontFamily);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GlobalSettingImplCopyWith<_$GlobalSettingImpl> get copyWith =>
      __$$GlobalSettingImplCopyWithImpl<_$GlobalSettingImpl>(this, _$identity);
}

abstract class _GlobalSetting implements GlobalSetting {
  const factory _GlobalSetting(
      {final Color? themeColor,
      final String? fontFamily}) = _$GlobalSettingImpl;

  @override
  Color? get themeColor;
  @override
  String? get fontFamily;
  @override
  @JsonKey(ignore: true)
  _$$GlobalSettingImplCopyWith<_$GlobalSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
