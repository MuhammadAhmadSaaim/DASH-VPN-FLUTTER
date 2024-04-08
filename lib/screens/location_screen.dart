import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';

import '../main.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _contrller = LocationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contrller.getVpnData();
  }

  @override
  void dispose() {
    super.dispose();
    _contrller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('DASH'),
        ),
        body: _contrller.isLoading.value
            ? loadingWidget()
            : _contrller.vpnlist.isEmpty
                ? noVPNsFound()
                : vpnData(),
      ),
    );
  }

  vpnData() => ListView.builder(
        itemCount: _contrller.vpnlist.length,
        itemBuilder: (ctx, i) => Text(_contrller.vpnlist[i].hostmame),
      );

  loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/loading.json',
              width: mq.width * .7,
            ),
            Text(
              "Loading VPNs...",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ],
        ),
      );

  noVPNsFound() {
    Center(
        child: Text(
      "No VPNs Found",
      style: TextStyle(fontSize: 18, color: Colors.black54),
    ));
  }
}
