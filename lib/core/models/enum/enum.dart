enum AuthType { login, register }

enum HistoryType { purchase, tip, transfer }

enum UserType {
  fan('fan'),
  creator('creator');

  final String value;
  const UserType(this.value);
}

enum CallStatus {
  incoming,
  calling,
  onCall,
  ended,
  none,
}
