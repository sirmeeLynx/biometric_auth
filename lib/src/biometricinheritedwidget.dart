import 'package:flutter/material.dart';
import 'package:biometric_auth/src/biometric.dart';

class BiometricStore extends InheritedWidget{
  final BiometricWidgetState biometric;

  BiometricStore({this.biometric, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(BiometricStore oldWidget){
    //print(oldWidget.biometric != biometric);
      return true;
  }
}