import '../domain/models/nfc_data.dart';

///
NfcData? parseWiFiPayload(String payload) {
  try {
    // Remove the initial 'WIFI:' and the trailing ';;'
    final String payloadData = payload.substring(5, payload.length - 2);

    // Split the payload into key-value pairs
    final List<String> parts = payloadData.split(';');
    String ssid = '';
    String securityType = '';
    String password = '';

    for (final String part in parts) {
      if (part.startsWith('S:')) {
        ssid = part.substring(2);
      } else if (part.startsWith('T:')) {
        securityType = part.substring(2);
      } else if (part.startsWith('P:')) {
        password = part.substring(2);
      }
    }

    return NfcData(security: securityType, name: ssid, password: password);
  } catch (e) {
    return null;
  }
}
