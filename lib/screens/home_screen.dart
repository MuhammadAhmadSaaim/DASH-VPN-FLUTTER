import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../main.dart';
import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _vpnState = VpnEngine.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig? _selectedVpn;

  RxBool _startTimer = false.obs;

  @override
  void initState() {
    super.initState();

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      setState(() => _vpnState = event);
    });

    initVpn();
  }

  void initVpn() async {
    //sample vpn config file (you can get more from https://www.vpngate.net/)
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
        country: 'Japan',
        username: 'vpn',
        password: 'vpn'));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/thailand.ovpn'),
        country: 'Thailand',
        username: 'vpn',
        password: 'vpn'));

    SchedulerBinding.instance.addPostFrameCallback(
        (t) => setState(() => _selectedVpn = _listVpn.first));
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
      bottomNavigationBar: changeLocation(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        vpnButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCard(
                title: "Country",
                subtitle: "Free",
                icon: CircleAvatar(
                  child: Icon(
                    Icons.vpn_key_rounded,
                    size: 30,
                  ),
                  radius: 30,
                  backgroundColor: Colors.greenAccent,
                )),
            HomeCard(
                title: "100 ms",
                subtitle: "PING",
                icon: CircleAvatar(
                  child: Icon(
                    Icons.equalizer_rounded,
                    size: 30,
                  ),
                  radius: 30,
                  backgroundColor: Colors.lightBlueAccent,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCard(
                title: "0 kbps",
                subtitle: "Download",
                icon: CircleAvatar(
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    size: 30,
                  ),
                  radius: 30,
                  backgroundColor: Colors.tealAccent,
                )),
            HomeCard(
                title: "0 kbps",
                subtitle: "Upload",
                icon: CircleAvatar(
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 30,
                  ),
                  radius: 30,
                  backgroundColor: Colors.deepPurpleAccent,
                )),
          ],
        )
      ]),
    );
  }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == VpnEngine.vpnDisconnected) {
      ///Start if stage is disconnected
      VpnEngine.startVpn(_selectedVpn!);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

  Widget vpnButton() => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                _startTimer.value = !_startTimer.value;
              },
              child: Container(
                padding: EdgeInsets.all((5)),
                decoration: BoxDecoration(
                    color: Colors.black54.withOpacity(.1),
                    shape: BoxShape.circle),
                child: Container(
                  padding: EdgeInsets.all((5)),
                  decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(.4),
                      shape: BoxShape.circle),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        color: Colors.black54, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: mq.height * .015, bottom: mq.height * 0.02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Not Connected",
              style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Obx(()=>CountDownTimer(startTimer: _startTimer.value)),
        ],
      );

  Widget changeLocation() => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(()=> LocationScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              color: Colors.black87,
              height: 60,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.globe,
                    size: 28,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  CircleAvatar(
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 26,
                      color: Colors.black54,
                    ),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

/*Center(
child: TextButton(
style: TextButton.styleFrom(
shape: StadiumBorder(),
backgroundColor: Theme.of(context).primaryColor,
),
child: Text(
_vpnState == VpnEngine.vpnDisconnected
? 'Connect VPN'
    : _vpnState.replaceAll("_", " ").toUpperCase(),
style: TextStyle(color: Colors.white),
),
onPressed: _connectClick,
),
),
StreamBuilder<VpnStatus?>(
initialData: VpnStatus(),
stream: VpnEngine.vpnStatusSnapshot(),
builder: (context, snapshot) => Text(
"${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
textAlign: TextAlign.center),
),

//sample vpn list
Column(
children: _listVpn
    .map(
(e) => ListTile(
title: Text(e.country),
leading: SizedBox(
height: 20,
width: 20,
child: Center(
child: _selectedVpn == e
? CircleAvatar(
backgroundColor: Colors.green)
    : CircleAvatar(
backgroundColor: Colors.grey)),
),
onTap: () {
log("${e.country} is selected");
setState(() => _selectedVpn = e);
},
),
)
.toList())
*/
