import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;

  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: mq.height * .012),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          controller.selectedVpn.value = vpn;
          Pref.vpn= vpn;
          Get.back();
          if (controller.vpnState == VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(
                Duration(seconds: 2), () => controller.connectToVpn());
          } else {
            controller.connectToVpn();
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              // Wrap ClipRect with ClipRRect
              borderRadius: BorderRadius.circular(5),
              // Specify the border radius
              child: Image.asset(
                'assets/flags/${vpn.CountryShort.toLowerCase()}.png',
                height: 40,
                width: mq.width *.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(vpn.CountryLong),
          subtitle: Row(
            children: [
              Icon(
                Icons.speed_rounded,
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                formatBytes(vpn.Speed, 2),
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpn.NumVpnSessions.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightText),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(CupertinoIcons.person_3),
            ],
          ),
        ),
      ),
    );
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
