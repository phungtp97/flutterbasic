import 'package:flutterbasic/base/basebloc.dart';
import 'package:flutterbasic/db/model.dart';
import 'package:rxdart/rxdart.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class BlocBasic extends BlocBase {

  PublishSubject<User> _getStream;

  BlocBasic(){
    _getStream = new PublishSubject<User>(onCancel: (){}, onListen: (){});
  }
  Observable<User> get userObservable => _getStream.stream;

  @override
  void dispose() {
    _getStream.close();
  }

  void getSampleUser() async
  {
    Error error = new StateError("Api error");
    appRepo.getUser().then((response) =>
    {
      if(response.statusCode == 200){
        _getStream.sink.add(User.fromMap(response.data))
      }
      else{
        _getStream.sink.addError(error)
      }
    });
  }

}
