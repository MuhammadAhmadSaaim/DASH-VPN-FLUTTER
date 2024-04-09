import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

import '../main.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _contrller = LocationController();

  @override
  Widget build(BuildContext context) {
    if(_contrller.vpnlist.isEmpty) _contrller.getVpnData();

    return Scaffold(
      appBar: AppBar(
        title: Text('DASH'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: ()=>_contrller.getVpnData(),
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: Obx(
        () => _contrller.isLoading.value
            ? loadingWidget(context)
            : _contrller.vpnlist.isEmpty
                ? noVPNsFound(context)
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

  loadingWidget(BuildContext context) => SizedBox(
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
              style: TextStyle(fontSize: 18, color: Theme.of(context).lightText),
            )
          ],
        ),
      );

  Widget noVPNsFound(BuildContext context) {
    return Center(
      child: Text(
        "No VPNs Found",
        style: TextStyle(fontSize: 18, color: Theme.of(context).lightText),
      ),
    );
  }
}
