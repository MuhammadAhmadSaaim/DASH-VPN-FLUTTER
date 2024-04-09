import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../controllers/home_controller.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('DASH'),
        leading: Icon(
          CupertinoIcons.home,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(Get.isDarkMode? ThemeMode.light: ThemeMode.dark);
                Pref.isDarkMode=!Pref.isDarkMode;
              },
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
      bottomNavigationBar: changeLocation(context),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Obx(() => vpnButton(context)),
        Obx(
          ()=> Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                  title: _controller.selectedVpn.value.CountryLong.isEmpty
                      ? 'Country'
                      : _controller.selectedVpn.value.CountryLong,
                  subtitle: "Server",
                  icon: CircleAvatar(
                    child: _controller.selectedVpn.value.CountryLong.isEmpty
                        ? Icon(
                            Icons.vpn_key_rounded,
                            size: 30,
                          )
                        : null,
                    backgroundImage: _controller.selectedVpn.value.CountryLong.isEmpty ? null :AssetImage('assets/flags/${_controller.selectedVpn.value.CountryShort.toLowerCase()}.png'),
                    radius: 30,
                    backgroundColor: Colors.greenAccent,
                  )),
              HomeCard(
                  title: _controller.selectedVpn.value.CountryLong.isEmpty
                      ? '100 ms'
                      : _controller.selectedVpn.value.Ping + " ms",
                  subtitle: "Ping",
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.equalizer_rounded,
                      size: 30,
                    ),
                    radius: 30,
                    backgroundColor: Colors.indigo,
                  )),
            ],
          ),
        ),
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                  title: "${snapshot.data?.byteIn ?? "0 Kbps"}",
                  subtitle: "Download",
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      size: 30,
                    ),
                    radius: 30,
                    backgroundColor: Colors.teal,
                  )),
              HomeCard(
                  title: "${snapshot.data?.byteOut ?? "0 Kbps"}",
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
          ),
        ),
      ]),
    );
  }

  Widget vpnButton(BuildContext context) => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                _controller.connectToVpn();
              },
              child: Container(
                padding: EdgeInsets.all((5)),
                decoration: BoxDecoration(
                    color: Theme.of(context).connectButton.withOpacity(.1),
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
                        color: Theme.of(context).connectButton, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
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
                color: Theme.of(context).connectButton, borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? "Not Connected"
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Obx(() => CountDownTimer(startTimer: _controller.vpnState.value==VpnEngine.vpnConnected)),
        ],
      );

  Widget changeLocation(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
                color: Theme.of(context).bottomNav,
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
