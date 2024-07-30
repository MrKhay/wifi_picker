// ignore_for_file: inference_failure_on_function_invocation, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
  String? securityType;

  void showSuccessBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CircleAvatar(
            backgroundColor: Colors.lightGreen,
            child: Icon(Icons.wifi),
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
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 5),
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
                        hintText: 'Select WiFi security type',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select WiFi security type';
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
                        hintText: 'Enter WiFi name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter WiFi name';
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
                        hintText: 'Enter WiFi password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter WiFi password';
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
                height: 50,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
