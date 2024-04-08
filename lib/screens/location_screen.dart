import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('DASH'),
      ),
      body: Obx(
        () => _contrller.isLoading.value
            ? loadingWidget()
            : _contrller.vpnlist.isEmpty
                ? loadingWidget()
                : vpnData(),
      ),
    );
  }

  vpnData() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _contrller.vpnlist.length,
        padding: EdgeInsets.only(
            top: mq.height * .015,
            bottom: mq.height * .1,
            left: mq.width * .04,
            right: mq.width * .04),
        itemBuilder: (ctx, i) => VpnCard(
          vpn: _contrller.vpnlist[i],
        ),
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
              "Fetching Servers",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ],
        ),
      );

  Widget noVPNsFound() {
    return Center(
      child: Text(
        "No VPNs Found",
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    );
  }
}
