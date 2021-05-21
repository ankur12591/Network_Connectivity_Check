import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetConnect(); // calls getconnect method to check which type if connection it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //color: Colors.orange,
      child: isInternetOn
          ? iswificonnected
              ? ShowWifi()
              : ShowMobile()
          : buildAlertDialog(),
    ));
  }

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text(
        "You are not Connected to Internet",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  Center ShowWifi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              " Your are connected to ${iswificonnected ? "WIFI" : "MOBILE DATA"}"),
          //Text(iswificonnected ? "$wifiBSSID" : "Not Wifi"),
          //Text("$wifiIP"),
          //Text("$wifiName")
        ],
      ),
    );
  }

  Center ShowMobile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(" Your are Connected to  MOBILE DATA"),
        ],
      ),
    );
  }

  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      iswificonnected = true;
      // setState(() async {
      // //   wifiBSSID = await (Connectivity().getWifiBSSID());
      //  //  wifiIP = await (Connectivity().checkConnectivity());
      // iswificonnected = true;
      // //   wifiIP = await (Connectivity().getWifiIP());
      // //   wifiName = await (Connectivity().getWifiName());
      //  });
    }
  }
}
