enum AuthType { login, register }

enum HistoryType { purchase, tip, transfer }

enum UserType {
  fan('fan'),
  creator('creator');

  final String value;
  const UserType(this.value);
}

enum CallStatus {
  calling('calling'),
  missed('missed'),
  ringing('ringing'),
  rejected('rejected'),
  inCall('inCall'),
  ended('ended');

  final String value;

  const CallStatus(this.value);

  static CallStatus fromString(String value) {
    return CallStatus.values.firstWhere((e) => e.value == value);
  }
}

enum RequestControlStatus {
  requestControl('requestControl'),
  requesting('requesting'),
  underControl('underControl');

  final String value;
  const RequestControlStatus(this.value);
}
