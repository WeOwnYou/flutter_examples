import 'package:flutter/services.dart';

class PlatformService{
  final method = const MethodChannel('CALL_METHOD');

  Future<String> callMethodChannel(String someText) async {
    try{
      return await method.invokeMethod('CALL', someText);
    }on PlatformException catch(e){
      print('Fail: ${e.message}');
      return 'Fail';
    }
  }
}