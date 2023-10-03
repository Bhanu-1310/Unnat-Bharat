import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicine_scheduler_app/controller/firebase_methods.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/add_sos_no.dart';
import 'package:medicine_scheduler_app/view/widgets/sos_showcase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class LocationOrSOSscreen extends StatefulWidget {
  const LocationOrSOSscreen({super.key});

  @override
  State<LocationOrSOSscreen> createState() => _LocationOrSOSscreenState();
}

class _LocationOrSOSscreenState extends State<LocationOrSOSscreen> {
  String lat = "";
  String long = "";

  Future<Position> getCurrentUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location services are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location services are denied permanently! Please Fix it to show location");
    }
    await Geolocator.getCurrentPosition().then((value) {
      lat = "${value.latitude}";
      long = "${value.longitude}";
    });
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 50);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {});
    });
  }

  // Future<void> openMap(String lat, String long) async {
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  //   await canLaunchUrl(Uri.parse(googleUrl))
  //       ? await launchUrl(Uri.parse(googleUrl))
  //       : throw "Could not launch $googleUrl";
  // }
  Future<void> openMap(String lat, String long) async {
    String googleUrl =
        await 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await FlutterWebBrowser.openWebPage(
      url: googleUrl,
    );
  }

  @override
  void initState() {
    super.initState();

    getCurrentUserLocation().then((value) {
      setState(() {
        lat = "${value.latitude}";
        long = "${value.longitude}";
      });
      if (userType == "User") {
        FirebaseMethods().updateLatAndLong(currentUserUid, lat, long);
      }
      liveLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Location & SOS".text.size(18).make(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          nextScreen(const AddSOSNumberScreen(), context);
        },
      ),
      body: Column(
        children: [
          userType == "User"
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      "Your Current Location is Latitude: $lat, Longitude: $long"
                          .text
                          .size(16)
                          .fontWeight(FontWeight.bold)
                          .make()
                          .box
                          .width(double.infinity)
                          .height(70)
                          .color(Colors.grey)
                          .roundedSM
                          .padding(const EdgeInsets.all(8.0))
                          .make(),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where("uid", isEqualTo: currentUserUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final document = snapshot.data!.docs.first;
                      lat = document['lat'];
                      long = document['long'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            "User's Current Location is Latitude: $lat, Longitude: $long"
                                .text
                                .size(16)
                                .fontWeight(FontWeight.bold)
                                .make()
                                .box
                                .width(double.infinity)
                                .height(70)
                                .color(Colors.grey)
                                .roundedSM
                                .padding(const EdgeInsets.all(8.0))
                                .make(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
          userType == "User"
              ? ElevatedButton(
                  child: "Refresh".text.make(),
                  onPressed: () {
                    initState();
                  },
                )
              : const SizedBox(),
          10.heightBox,
          ElevatedButton(
            child: "Open in Google Maps".text.make(),
            onPressed: () {
              openMap(lat, long);
            },
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: phNumbers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    FlutterPhoneDirectCaller.callNumber(phNumbers[index]);
                  },
                  child: SOSshowcase(
                    contactName: contactNames[index],
                    phNumber: phNumbers[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
