// ignore_for_file: inference_failure_on_function_invocation, public_member_api_docs

import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/text_font.dart';

class Writenfc extends StatefulWidget {
  const Writenfc({super.key});

  @override
  State<Writenfc> createState() => _WritenfcState();
}

class _WritenfcState extends State<Writenfc> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController securitycontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  void showbox(BuildContext context) {
    // ignore: discarded_futures
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const CircleAvatar(
                backgroundColor: Colors.lightGreen, child: Icon(Icons.wifi)),
            content: const Text(
                "You've have succefully connected to HNG Workspace Tag"),
            actions: <Widget>[
              Button(
                width: MediaQuery.of(context).size.width,
                height: 50,
                text: 'Done',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('*Wifi Details*',
                style: textfont(20, FontWeight.normal, Colors.black)),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Security Type',
                        style: textfont(15, FontWeight.normal, Colors.black)),
                    TextFormField(
                      controller: securitycontroller,
                      decoration: const InputDecoration(
                          hintText: 'Placeholder',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Name',
                        style: textfont(15, FontWeight.normal, Colors.black)),
                    TextFormField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          hintText: 'Placeholder',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Password',
                        style: textfont(15, FontWeight.normal, Colors.black)),
                    TextFormField(
                      controller: passwordcontroller,
                      decoration: const InputDecoration(
                          hintText: 'Placeholder',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder()),
                    ),
                  ],
                )),
            const SizedBox(
              height: 35,
            ),
            Button(
                onTap: () {
                  showbox(context);
                },
                width: MediaQuery.of(context).size.width,
                height: 50,
                text: 'Save to Nfc Tag')
          ],
        ),
      )),
    );
  }
}
