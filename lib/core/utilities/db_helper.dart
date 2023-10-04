class DbKey {
  DbKey._();
  static const String isOnline = 'isOnline';
  static const String callStatus = 'callStatus';
  static const String outgoing = 'outgoing';
  static const String incoming = 'incoming';
  static const String ended = 'ended';
  static const String started = 'started';
  static const String callTime = 'callTime';
  static const String type = 'type';
}

class DbCollection {
  DbCollection._();
  static const String users = 'users';
  static const String categories = 'categories';
  static const String creators = 'creators';
  static const String calls = 'calls';
  static const String callHistories = 'callHistories';
}

// dao/person_dao.dart

