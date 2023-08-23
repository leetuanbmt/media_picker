// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TabItem {
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TabItemCopyWith<TabItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabItemCopyWith<$Res> {
  factory $TabItemCopyWith(TabItem value, $Res Function(TabItem) then) =
      _$TabItemCopyWithImpl<$Res, TabItem>;
  @useResult
  $Res call({String title, String image});
}

/// @nodoc
class _$TabItemCopyWithImpl<$Res, $Val extends TabItem>
    implements $TabItemCopyWith<$Res> {
  _$TabItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TabItemCopyWith<$Res> implements $TabItemCopyWith<$Res> {
  factory _$$_TabItemCopyWith(
          _$_TabItem value, $Res Function(_$_TabItem) then) =
      __$$_TabItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String image});
}

/// @nodoc
class __$$_TabItemCopyWithImpl<$Res>
    extends _$TabItemCopyWithImpl<$Res, _$_TabItem>
    implements _$$_TabItemCopyWith<$Res> {
  __$$_TabItemCopyWithImpl(_$_TabItem _value, $Res Function(_$_TabItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_$_TabItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TabItem implements _TabItem {
  const _$_TabItem({required this.title, required this.image});

  @override
  final String title;
  @override
  final String image;

  @override
  String toString() {
    return 'TabItem(title: $title, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TabItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TabItemCopyWith<_$_TabItem> get copyWith =>
      __$$_TabItemCopyWithImpl<_$_TabItem>(this, _$identity);
}

abstract class _TabItem implements TabItem {
  const factory _TabItem(
      {required final String title, required final String image}) = _$_TabItem;

  @override
  String get title;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_TabItemCopyWith<_$_TabItem> get copyWith =>
      throw _privateConstructorUsedError;
}
