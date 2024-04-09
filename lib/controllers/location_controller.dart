import 'package:get/get.dart';

import '../apis/apis.dart';
import '../models/vpn.dart';

class LocationController extends GetxController{
  List<Vpn> vpnlist=[];
  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async{
    isLoading.value=true;
    vpnlist.clear();
    vpnlist=await APIs.getVPNServers();
    isLoading.value=false;
  }
}