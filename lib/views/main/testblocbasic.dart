import 'package:flutterbasic/base/basebloc.dart';
import 'dart:async';
import 'package:flutterbasic/db/model.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class BlocBasic extends BlocBase {
  StreamController streamDataController = StreamController<User>.broadcast();

  Sink get dataSink => streamDataController.sink;

  Stream<User> get dataStream => streamDataController.stream;

  @override
  void dispose() {
    streamDataController.close();
  }

  void getSampleUser() async
  {
    appRepo.getUser().then((response) =>
    {
      if(response.data is Map<String, dynamic>){
        dataSink.add(User.fromMap(response.data))
      }
    });
  }

}
