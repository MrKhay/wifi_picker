import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../../../_common/common.dart';

///
class AvaliableWifiWiget extends StatefulWidget {
  ///
  final void Function(WiFiAccessPoint) onNetworkSelected;

  ///
  const AvaliableWifiWiget({super.key, required this.onNetworkSelected});

  @override
  AvaliableWifiWigetState createState() => AvaliableWifiWigetState();
}

///
class AvaliableWifiWigetState extends State<AvaliableWifiWiget> {
  late NearbyWifiRepository _nearbyWifiRepository;

  @override
  void initState() {
    _nearbyWifiRepository = NearbyWifiRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kGap_3),
            topRight: Radius.circular(kGap_3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kGap_2, vertical: kGap_1),
      height: context.screenSize.height * 0.5,
      child: FutureBuilder<CustomResponse<List<WiFiAccessPoint>>>(
        future: _nearbyWifiRepository.startScan(),
        builder: (BuildContext context,
            AsyncSnapshot<CustomResponse<List<WiFiAccessPoint>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          debugPrint('Stae: ${snapshot.connectionState}');
          final CustomResponse<List<WiFiAccessPoint>>? data = snapshot.data;

          if (data == null) {
            return const Center(
              child: Text(kSomethingWentWrong),
            );
          }

          if (data.error != null) {
            return Center(
              child: Text(data.error ?? kSomethingWentWrong),
            );
          }
          final List<WiFiAccessPoint> accessPoints = data.value!;

          if (accessPoints.isEmpty) {
            return const Center(
              child: Text('No wifi network found'),
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: kGap_1),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: kGap_1),
              itemCount: accessPoints.length,
              itemBuilder: (BuildContext context, int index) {
                final WiFiAccessPoint accessPoint = accessPoints[index];
                return _wifiTile(accessPoint, widget.onNetworkSelected);
              },
            );
          }
        },
      ),
    );
  }

  Widget _wifiTile(WiFiAccessPoint accessPoint,
          void Function(WiFiAccessPoint) onNetworkSelected) =>
      ListTile(
        onTap: () {
          onNetworkSelected.call(accessPoint);
          Navigator.pop(context); // Close the bottom sheet
        },
        title: Text(accessPoint.ssid),
        enableFeedback: true,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(kGap_3)),
        trailing: Icon(
          Icons.wifi,
          color: context.colorScheme.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: kGap_1),
      );
}
