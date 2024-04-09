import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'dart:developer' as developer;

import 'package:vpn_basic_project/models/vpn.dart';

import '../helpers/pref.dart';
import '../models/ip_details.dart';

class APIs{
  static Future<List<Vpn>> getVPNServers () async{
    final List<Vpn> vpnList=[];

    try {
      final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split("#")[1].replaceAll('*', '');
      List<List<dynamic>> vpnServersList = const CsvToListConverter().convert(csvString);
      
      final header = vpnServersList[0];
      
      for (int i =1;i<vpnServersList.length-1;++i) {
        Map<String, dynamic> tempJson = {};
          for (int j =0;j<header.length;++j) {
            tempJson.addAll({header[j].toString() : vpnServersList[i][j]});
          }
          vpnList.add(Vpn.fromJson((tempJson)));
      }
    } catch (e) {
      developer.log('\nGetVPNSServerE: $e');
    }

    vpnList.shuffle();

    if(vpnList.isNotEmpty)
      {
        Pref.vpnList = vpnList;
      }
    return vpnList;
  }

  static Future<void> getIPDetails ({required Rx<IPDetails> ipData}) async{

    try {
      final res = await get(Uri.parse('http://ip-api.com/json'));
      final data = jsonDecode(res.body);

      ipData.value = IPDetails.fromJson(data);
    } catch (e) {
      developer.log('\nGet IPDetails: $e');
    }
  }
}