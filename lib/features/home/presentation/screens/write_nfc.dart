// ignore_for_file: inference_failure_on_function_invocation, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../_common/domain/models/nfc_data.dart';
import '../../../features.dart';
import '../widgets/button_widget.dart';

class WriteNfc extends StatefulWidget {
  final NfcTag tag;
  const WriteNfc({super.key, required this.tag});

  @override
  State<WriteNfc> createState() => _WriteNfcState();
}

class _WriteNfcState extends State<WriteNfc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  NfcData? nfcData;
  String? securityType = 'WEP';

  void showSuccessBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CircleAvatar(
            backgroundColor: Colors.lightGreen,
            child: Icon(
              Icons.wifi,
            ),
          ),
          content: const Text('Data successfully written to tag'),
          actions: <Widget>[
            Button(
              width: MediaQuery.of(context).size.width,
              height: 50,
              text: 'Done',
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> writeWifiCredentials() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final String ssid = nameController.text;
      final String password = passwordController.text;

      // Encode WiFi credentials in the WiFi Simple Configuration format
      final String wifiPayload = 'WIFI:S:$ssid;T:$securityType;P:$password;;';

      // Convert the payload to bytes
      final NdefMessage ndefMessage = NdefMessage(<NdefRecord>[
        NdefRecord.createText(wifiPayload),
      ]);

      try {
        // Start the NFC session

        // Write to the NFC tag
        final Ndef? ndef = Ndef.from(widget.tag);
        if (ndef == null || !ndef.isWritable) {
          context.showSnackBar('Tag is not compatible',
              type: SnackBarType.error);
          return;
        }
        await ndef.write(ndefMessage);
        showSuccessBox(context);
        triggerVibration();
      } catch (e) {
        // Handle the error
        context.showSnackBar('Error writing to NFC tag: $e',
            type: SnackBarType.error);
      }
    }
  }

  @override
  void initState() {
    if (widget.tag.data.isNotEmpty) {
      nfcData = NfcData.fromMap(widget.tag.data);
      nameController.text = nfcData?.name ?? '';
      passwordController.text = nfcData?.password ?? '';
      securityType = nfcData?.security ?? '';
    }
    super.initState();
  }

  void triggerVibration() {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        context: context,
        centerTitle: true,
        title: kWifiDetails,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _showWifiNetworks(context);
              },
              icon: Icon(
                Icons.wifi_find,
                color: context.colorScheme.primary,
              ))
        ],
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kGap_3, vertical: kGap_3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Security Type', style: context.textTheme.bodyLarge),
                    const SizedBox(height: kGap_1),
                    DropdownButtonFormField<String>(
                      value: securityType,
                      onChanged: (String? newValue) {
                        setState(() {
                          securityType = newValue;
                        });
                      },
                      items: <String>['WPA', 'WEP', 'None']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        hintText: 'Select Wi-Fi security type',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select Wi-Fi security type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: kGap_2),
                    Text('Name', style: context.textTheme.bodyLarge),
                    const SizedBox(height: kGap_1),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Wi-Fi name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Wi-Fi name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: kGap_2),
                    Text('Password', style: context.textTheme.bodyLarge),
                    const SizedBox(height: kGap_1),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Wi-Fi password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Wi-Fi password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kGap_4),
              Button(
                onTap: writeWifiCredentials,
                width: MediaQuery.of(context).size.width,
                height: kGap_5 - 10,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWifiNetworks(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AvaliableWifiWiget(
          onNetworkSelected: (WiFiAccessPoint network) {
            nameController.text = network.ssid;
          },
        );
      },
    );
  }
}
