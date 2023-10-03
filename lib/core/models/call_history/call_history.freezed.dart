// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallHistory _$CallHistoryFromJson(Map<String, dynamic> json) {
  return _CallHistory.fromJson(json);
}

/// @nodoc
mixin _$CallHistory {
  String get callerId => throw _privateConstructorUsedError;
  String get callerName => throw _privateConstructorUsedError;
  String get callerPic => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String get receiverPic => throw _privateConstructorUsedError;
  String get channelId => throw _privateConstructorUsedError;
  bool get hasDialled => throw _privateConstructorUsedError;
  bool get isCallMissed => throw _privateConstructorUsedError;
  DateTime get callTime => throw _privateConstructorUsedError;
  CallStatus get callStatus => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get started => throw _privateConstructorUsedError;
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get ended => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallHistoryCopyWith<CallHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallHistoryCopyWith<$Res> {
  factory $CallHistoryCopyWith(
          CallHistory value, $Res Function(CallHistory) then) =
      _$CallHistoryCopyWithImpl<$Res, CallHistory>;
  @useResult
  $Res call(
      {String callerId,
      String callerName,
      String callerPic,
      String receiverId,
      String receiverName,
      String receiverPic,
      String channelId,
      bool hasDialled,
      bool isCallMissed,
      DateTime callTime,
      CallStatus callStatus,
      String type,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? started,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? ended});
}

/// @nodoc
class _$CallHistoryCopyWithImpl<$Res, $Val extends CallHistory>
    implements $CallHistoryCopyWith<$Res> {
  _$CallHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callerId = null,
    Object? callerName = null,
    Object? callerPic = null,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? receiverPic = null,
    Object? channelId = null,
    Object? hasDialled = null,
    Object? isCallMissed = null,
    Object? callTime = null,
    Object? callStatus = null,
    Object? type = null,
    Object? started = freezed,
    Object? ended = freezed,
  }) {
    return _then(_value.copyWith(
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      callerName: null == callerName
          ? _value.callerName
          : callerName // ignore: cast_nullable_to_non_nullable
              as String,
      callerPic: null == callerPic
          ? _value.callerPic
          : callerPic // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      receiverPic: null == receiverPic
          ? _value.receiverPic
          : receiverPic // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      hasDialled: null == hasDialled
          ? _value.hasDialled
          : hasDialled // ignore: cast_nullable_to_non_nullable
              as bool,
      isCallMissed: null == isCallMissed
          ? _value.isCallMissed
          : isCallMissed // ignore: cast_nullable_to_non_nullable
              as bool,
      callTime: null == callTime
          ? _value.callTime
          : callTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      callStatus: null == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      started: freezed == started
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ended: freezed == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallHistoryImplCopyWith<$Res>
    implements $CallHistoryCopyWith<$Res> {
  factory _$$CallHistoryImplCopyWith(
          _$CallHistoryImpl value, $Res Function(_$CallHistoryImpl) then) =
      __$$CallHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String callerId,
      String callerName,
      String callerPic,
      String receiverId,
      String receiverName,
      String receiverPic,
      String channelId,
      bool hasDialled,
      bool isCallMissed,
      DateTime callTime,
      CallStatus callStatus,
      String type,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? started,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? ended});
}

/// @nodoc
class __$$CallHistoryImplCopyWithImpl<$Res>
    extends _$CallHistoryCopyWithImpl<$Res, _$CallHistoryImpl>
    implements _$$CallHistoryImplCopyWith<$Res> {
  __$$CallHistoryImplCopyWithImpl(
      _$CallHistoryImpl _value, $Res Function(_$CallHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callerId = null,
    Object? callerName = null,
    Object? callerPic = null,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? receiverPic = null,
    Object? channelId = null,
    Object? hasDialled = null,
    Object? isCallMissed = null,
    Object? callTime = null,
    Object? callStatus = null,
    Object? type = null,
    Object? started = freezed,
    Object? ended = freezed,
  }) {
    return _then(_$CallHistoryImpl(
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      callerName: null == callerName
          ? _value.callerName
          : callerName // ignore: cast_nullable_to_non_nullable
              as String,
      callerPic: null == callerPic
          ? _value.callerPic
          : callerPic // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      receiverPic: null == receiverPic
          ? _value.receiverPic
          : receiverPic // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      hasDialled: null == hasDialled
          ? _value.hasDialled
          : hasDialled // ignore: cast_nullable_to_non_nullable
              as bool,
      isCallMissed: null == isCallMissed
          ? _value.isCallMissed
          : isCallMissed // ignore: cast_nullable_to_non_nullable
              as bool,
      callTime: null == callTime
          ? _value.callTime
          : callTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      callStatus: null == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      started: freezed == started
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ended: freezed == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallHistoryImpl implements _CallHistory {
  const _$CallHistoryImpl(
      {required this.callerId,
      required this.callerName,
      required this.callerPic,
      required this.receiverId,
      required this.receiverName,
      required this.receiverPic,
      required this.channelId,
      required this.hasDialled,
      required this.isCallMissed,
      required this.callTime,
      required this.callStatus,
      required this.type,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      this.started,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      this.ended});

  factory _$CallHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallHistoryImplFromJson(json);

  @override
  final String callerId;
  @override
  final String callerName;
  @override
  final String callerPic;
  @override
  final String receiverId;
  @override
  final String receiverName;
  @override
  final String receiverPic;
  @override
  final String channelId;
  @override
  final bool hasDialled;
  @override
  final bool isCallMissed;
  @override
  final DateTime callTime;
  @override
  final CallStatus callStatus;
  @override
  final String type;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  final DateTime? started;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  final DateTime? ended;

  @override
  String toString() {
    return 'CallHistory(callerId: $callerId, callerName: $callerName, callerPic: $callerPic, receiverId: $receiverId, receiverName: $receiverName, receiverPic: $receiverPic, channelId: $channelId, hasDialled: $hasDialled, isCallMissed: $isCallMissed, callTime: $callTime, callStatus: $callStatus, type: $type, started: $started, ended: $ended)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallHistoryImpl &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.callerName, callerName) ||
                other.callerName == callerName) &&
            (identical(other.callerPic, callerPic) ||
                other.callerPic == callerPic) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPic, receiverPic) ||
                other.receiverPic == receiverPic) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.hasDialled, hasDialled) ||
                other.hasDialled == hasDialled) &&
            (identical(other.isCallMissed, isCallMissed) ||
                other.isCallMissed == isCallMissed) &&
            (identical(other.callTime, callTime) ||
                other.callTime == callTime) &&
            (identical(other.callStatus, callStatus) ||
                other.callStatus == callStatus) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.started, started) || other.started == started) &&
            (identical(other.ended, ended) || other.ended == ended));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      callerId,
      callerName,
      callerPic,
      receiverId,
      receiverName,
      receiverPic,
      channelId,
      hasDialled,
      isCallMissed,
      callTime,
      callStatus,
      type,
      started,
      ended);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallHistoryImplCopyWith<_$CallHistoryImpl> get copyWith =>
      __$$CallHistoryImplCopyWithImpl<_$CallHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallHistoryImplToJson(
      this,
    );
  }
}

abstract class _CallHistory implements CallHistory {
  const factory _CallHistory(
      {required final String callerId,
      required final String callerName,
      required final String callerPic,
      required final String receiverId,
      required final String receiverName,
      required final String receiverPic,
      required final String channelId,
      required final bool hasDialled,
      required final bool isCallMissed,
      required final DateTime callTime,
      required final CallStatus callStatus,
      required final String type,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      final DateTime? started,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      final DateTime? ended}) = _$CallHistoryImpl;

  factory _CallHistory.fromJson(Map<String, dynamic> json) =
      _$CallHistoryImpl.fromJson;

  @override
  String get callerId;
  @override
  String get callerName;
  @override
  String get callerPic;
  @override
  String get receiverId;
  @override
  String get receiverName;
  @override
  String get receiverPic;
  @override
  String get channelId;
  @override
  bool get hasDialled;
  @override
  bool get isCallMissed;
  @override
  DateTime get callTime;
  @override
  CallStatus get callStatus;
  @override
  String get type;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get started;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get ended;
  @override
  @JsonKey(ignore: true)
  _$$CallHistoryImplCopyWith<_$CallHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
