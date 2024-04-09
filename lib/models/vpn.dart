class Vpn {
  late final String hostmame;
  late final String IP;
  late final String Ping;
  late final int Speed;
  late final String CountryLong;
  late final String CountryShort;
  late final int NumVpnSessions;
  late final String OpenVPNConfigDataBase64;

  Vpn({
    required this.hostmame,
    required this.IP,
    required this.Ping,
    required this.Speed,
    required this.CountryLong,
    required this.CountryShort,
    required this.NumVpnSessions,
    required this.OpenVPNConfigDataBase64,
  });

  Vpn.fromJson(Map<String, dynamic> json){
    hostmame = json['HostName'] ?? '';
    IP = json['IP'] ?? '';
    Ping = json['Ping'].toString();
    Speed = json['Speed'] ?? 0;
    CountryLong = json['CountryLong'] ?? '';
    CountryShort = json['CountryShort'] ?? '';
    NumVpnSessions = json['NumVpnSessions'] ?? 0;
    OpenVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['HostName'] = hostmame;
    data['IP'] = IP;
    data['Ping'] = Ping;
    data['Speed'] = Speed;
    data['CountryLong'] = CountryLong;
    data['CountryShort'] = CountryShort;
    data['NumVpnSessions'] = NumVpnSessions;
    data['OpenVPN_ConfigData_Base64'] = OpenVPNConfigDataBase64;
    return data;
  }
}