# biometric_auth

This package provides a stateful widget to perform local, on-device authentication of the user referring to biometric authentication on iOS (Touch ID or lock code) and the fingerprint APIs on Android (introduced in Android 6.0).

## Getting Started

To use this widget, add `biometric_auth` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). 

The widget implementation uses the **StatefulWidget** named **BiometricWidget** which receives a `title` which gets displayed on the dialog of
the native biometric interface when popped up.

Checkout the sample below for usage of the widget.


### Example  
  
```dart
import 'package:flutter/material.dart';
import 'package:biometric_auth/biometric_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BiometricWidget(
      title: "Confirm your Fingerprint now",
      child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fingerprint Authentication'),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var biometric = BiometricWidget.of(context);
    bool hasFingerPrintSupport = biometric.hasFingerPrintSupport;
    String authorizedOrNot = biometric.authorizedOrNot;
    var availableBiometricType = biometric.availableBiometricType;
    var authenticateMe = biometric.authenticateMe;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Has FingerPrint Support : $hasFingerPrintSupport"),
            Text(
                "List of Biometrics Support: ${availableBiometricType.toString()}"),
            Text("Authorized : $authorizedOrNot"),
            RaisedButton(
              child: Text("Authorize Now"),
              color: Colors.green,
              onPressed: authenticateMe,
            ),
          ],
        ),
      ),
    );
  }
}
