// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HistoryModel {
  String get suffix => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get point => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  HistoryType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryModelCopyWith<HistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryModelCopyWith<$Res> {
  factory $HistoryModelCopyWith(
          HistoryModel value, $Res Function(HistoryModel) then) =
      _$HistoryModelCopyWithImpl<$Res, HistoryModel>;
  @useResult
  $Res call(
      {String suffix,
      String title,
      int point,
      DateTime date,
      HistoryType type});
}

/// @nodoc
class _$HistoryModelCopyWithImpl<$Res, $Val extends HistoryModel>
    implements $HistoryModelCopyWith<$Res> {
  _$HistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suffix = null,
    Object? title = null,
    Object? point = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      suffix: null == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HistoryType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryModelImplCopyWith<$Res>
    implements $HistoryModelCopyWith<$Res> {
  factory _$$HistoryModelImplCopyWith(
          _$HistoryModelImpl value, $Res Function(_$HistoryModelImpl) then) =
      __$$HistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String suffix,
      String title,
      int point,
      DateTime date,
      HistoryType type});
}

/// @nodoc
class __$$HistoryModelImplCopyWithImpl<$Res>
    extends _$HistoryModelCopyWithImpl<$Res, _$HistoryModelImpl>
    implements _$$HistoryModelImplCopyWith<$Res> {
  __$$HistoryModelImplCopyWithImpl(
      _$HistoryModelImpl _value, $Res Function(_$HistoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suffix = null,
    Object? title = null,
    Object? point = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$HistoryModelImpl(
      suffix: null == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HistoryType,
    ));
  }
}

/// @nodoc

class _$HistoryModelImpl implements _HistoryModel {
  const _$HistoryModelImpl(
      {this.suffix = '',
      required this.title,
      required this.point,
      required this.date,
      this.type = HistoryType.tip});

  @override
  @JsonKey()
  final String suffix;
  @override
  final String title;
  @override
  final int point;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final HistoryType type;

  @override
  String toString() {
    return 'HistoryModel(suffix: $suffix, title: $title, point: $point, date: $date, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryModelImpl &&
            (identical(other.suffix, suffix) || other.suffix == suffix) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.point, point) || other.point == point) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, suffix, title, point, date, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryModelImplCopyWith<_$HistoryModelImpl> get copyWith =>
      __$$HistoryModelImplCopyWithImpl<_$HistoryModelImpl>(this, _$identity);
}

abstract class _HistoryModel implements HistoryModel {
  const factory _HistoryModel(
      {final String suffix,
      required final String title,
      required final int point,
      required final DateTime date,
      final HistoryType type}) = _$HistoryModelImpl;

  @override
  String get suffix;
  @override
  String get title;
  @override
  int get point;
  @override
  DateTime get date;
  @override
  HistoryType get type;
  @override
  @JsonKey(ignore: true)
  _$$HistoryModelImplCopyWith<_$HistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
