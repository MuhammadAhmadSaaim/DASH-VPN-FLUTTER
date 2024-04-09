import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

import '../apis/apis.dart';
import '../main.dart';
import '../models/ip_details.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData =  IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Network Info'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: (){
            ipData.value = IPDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
          },
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: Obx(
        ()=> ListView(
          padding: EdgeInsets.only(left: mq.width*.04, right: mq.width*.04, top: mq.height*.015,bottom: mq.height*.1),
          physics: BouncingScrollPhysics(),
          children: [
            NetworkCard(data: NetworkData(title: 'IP Address', subtitle: ipData.value.query.isEmpty? 'Fetching...':ipData.value.query, icon: Icon(CupertinoIcons.location_solid,color: Colors.teal,))),
            NetworkCard(data: NetworkData(title: 'Internet Provider', subtitle: ipData.value.isp.isEmpty? 'Fetching...':ipData.value.isp, icon: Icon(Icons.business,color: Colors.greenAccent))),
            NetworkCard(data: NetworkData(title: 'Location', subtitle: ipData.value.country.isEmpty? 'Fetching...': '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}', icon: Icon(CupertinoIcons.location,color: Colors.indigo))),
            NetworkCard(data: NetworkData(title: 'Zip-Code', subtitle: ipData.value.zip.isEmpty? 'Fetching...':ipData.value.zip, icon: Icon(CupertinoIcons.lock,color: Colors.deepPurpleAccent))),
            NetworkCard(data: NetworkData(title: 'Timezone', subtitle: ipData.value.timezone.isEmpty? 'Fetching...':ipData.value.timezone, icon: Icon(CupertinoIcons.time,color: Colors.purple))),
          ],
        ),
      ),
    );
  }
}
