import 'package:flutter/material.dart';
//1. imported local authentication plugin
import 'package:local_auth/local_auth.dart';
import 'package:biometric_auth/src/biometricinheritedwidget.dart';

class BiometricWidget extends StatefulWidget {
  final Widget child;
  final String title;

  const BiometricWidget({Key key, @required this.child, this.title}) : super(key: key);

  static BiometricWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BiometricStore>().biometric;
  }

  @override
  State<StatefulWidget> createState() {
    return BiometricWidgetState(title: title);
  }
}

class BiometricWidgetState extends State<BiometricWidget> {

  BiometricWidgetState({this.title});
  // 1. declare title for fingerprint dialog
  final String title;
  // 2. created object of localauthentication class
   final LocalAuthentication _localAuthentication = LocalAuthentication();
  // 3. variable for track whether your device support local authentication means
  //    have fingerprint or face recognization sensor or not
   bool _hasFingerPrintSupport = false;
  // 4. we will set state whether user authorized or not
   String _authorizedOrNot = "Not Authorized";
  // 5. list of avalable biometric authentication supports of your device will be saved in this array
   List<BiometricType> _availableBuimetricType = List<BiometricType>();

   bool get hasFingerPrintSupport => _hasFingerPrintSupport;

   String get authorizedOrNot => _authorizedOrNot;

   List<BiometricType> get availableBiometricType => _availableBuimetricType;

  @override
  void initState() {
    _getFingerPrintSupport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BiometricStore(
      child: widget.child,
      biometric: this,
    );
  }

   Future<void> _getFingerPrintSupport() async{
     await _getBiometricsSupport();
     await _getAvailableSupport();
  }

   Future<void> _getBiometricsSupport() async {
    // 6. this method checks whether your device has biometric support or not
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState((){
      _hasFingerPrintSupport = hasFingerPrintSupport;
    });
  }

   Future<void> _getAvailableSupport() async {
    // 7. this method fetches all the available biometric supports of the device
    List<BiometricType> availableBuimetricType = List<BiometricType>();
    try {
      availableBuimetricType =
          await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState((){
       _availableBuimetricType = availableBuimetricType;
    });
  }

   Future<void> authenticateMe() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: title ?? "Authenticate for Testing", // message for dialog
        useErrorDialogs: true,// show error in dialog
        stickyAuth: true,// native process
      );
    } catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState((){
        _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
  }

}