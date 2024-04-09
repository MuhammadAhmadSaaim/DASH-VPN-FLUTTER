import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

import '../main.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Info'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: (){},
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: mq.width*.04, right: mq.width*.04, top: mq.height*.015,bottom: mq.height*.1),
        physics: BouncingScrollPhysics(),
        children: [
          NetworkCard(data: NetworkData(title: 'IP Address', subtitle: 'Not Available', icon: Icon(CupertinoIcons.location_solid,color: Colors.teal,))),
          NetworkCard(data: NetworkData(title: 'Internet Provider', subtitle: 'Unknown', icon: Icon(Icons.business,color: Colors.greenAccent))),
          NetworkCard(data: NetworkData(title: 'Location', subtitle: 'Fetching..', icon: Icon(CupertinoIcons.location,color: Colors.indigo))),
          NetworkCard(data: NetworkData(title: 'Pin-Code', subtitle: '----', icon: Icon(CupertinoIcons.lock,color: Colors.deepPurpleAccent))),
          NetworkCard(data: NetworkData(title: 'Timezone', subtitle: 'Not Available', icon: Icon(CupertinoIcons.time,color: Colors.purple))),
        ],
      ),
    );
  }
}
