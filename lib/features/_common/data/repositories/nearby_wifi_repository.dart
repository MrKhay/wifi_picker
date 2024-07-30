// ignore_for_file: always_specify_types

import 'package:wifi_scan/wifi_scan.dart';

import '../../common.dart';

/// Handles scanning avaliable wifi networks
class NearbyWifiRepository {
  late WiFiScan _wiFiScan;

  /// Handles scanning avaliable wifi networks
  NearbyWifiRepository() {
    _wiFiScan = WiFiScan.instance;
  }

  Future<CustomResponse<List<WiFiAccessPoint>>> startScan() async {
    // check platform support and necessary requirements
    final CanStartScan can = await _wiFiScan.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        // start full scan async-ly
        await WiFiScan.instance.startScan();
        final responce = await _getScannedResults();
        return responce;
      case CanStartScan.notSupported:
        return CustomResponse(
            error: "Can't get avaliable wifi networks on this device");
      case CanStartScan.noLocationPermissionRequired:
        return CustomResponse(error: 'Location permission is required.');
      case CanStartScan.noLocationPermissionDenied:
        return CustomResponse(error: 'Location permission is denied');
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
        return CustomResponse(
            error: 'Location permission accuracy needs to be upgraded.');
      case CanStartScan.noLocationServiceDisabled:
        return CustomResponse(error: 'Location serives needes to be enabled');
      case CanStartScan.failed:
        return CustomResponse(error: 'Scan failed');
    }
  }

  Future<CustomResponse<List<WiFiAccessPoint>>> _getScannedResults() async {
    // check platform support and necessary requirements
    final CanGetScannedResults can =
        await _wiFiScan.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        // get scanned results
        final List<WiFiAccessPoint> accessPoints =
            await WiFiScan.instance.getScannedResults();

        return CustomResponse(value: accessPoints);
      // ...
      // ... handle other cases of CanGetScannedResults values
      case CanGetScannedResults.notSupported:
        return CustomResponse(
            error: "Can't get avaliable wifi networks on this device");
      case CanGetScannedResults.noLocationPermissionRequired:
        return CustomResponse(error: 'Location permission is required.');

      case CanGetScannedResults.noLocationPermissionDenied:
        return CustomResponse(error: 'Location permission is denied');
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
        return CustomResponse(
            error: 'Location permission accuracy needs to be upgraded.');
      case CanGetScannedResults.noLocationServiceDisabled:
        return CustomResponse(error: 'Location serives needes to be enabled');
    }
  }
}
