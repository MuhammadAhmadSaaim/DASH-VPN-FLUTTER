import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/apis/apis.dart';

import '../main.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getVPNServers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASH'),
        leading: Icon(
          CupertinoIcons.home,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.brightness_medium_rounded,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.info,
                size: 28,
              )),
        ],
      ),
      body: loadingWidget(),
    );
  }

  loadingWidget () => SizedBox(
    width: double.infinity,height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset('assets/lottie/loading.json',width: mq.width*.7,),
        Text("Loading VPNs...", style: TextStyle(fontSize: 18,color: Colors.black54),)
      ],
    ),
  );

  noVPNsFound(){
    Center(child: Text("No VPNs Found", style: TextStyle(fontSize: 18,color: Colors.black54),));
  }
}
