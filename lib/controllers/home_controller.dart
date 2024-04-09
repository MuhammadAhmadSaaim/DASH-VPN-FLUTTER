import 'dart:convert';

import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';

import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController{
  final Rx<Vpn>selectedVpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() {
    if(selectedVpn.value.OpenVPNConfigDataBase64.isEmpty) {
      
      MyDialogs.info(msg: "Select a Location by clicking \'Chnage Location\'");
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final data = Base64Decoder().convert(selectedVpn.value.OpenVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(country: selectedVpn.value.CountryLong, username: 'vpn', password: 'vpn', config: config);

      ///Start if stage is disconnected
      VpnEngine.startVpn(vpnConfig);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

  String get getButtonText{
    switch(vpnState.value){
      case VpnEngine.vpnDisconnected:
        return "Tap to Conect";
      case VpnEngine.vpnConnected:
        return "Disconnect";
      default:
        return "Connecting...";
    }
  }
}