import 'package:flutterbasic/base/basebloc.dart';
import 'package:rxdart/rxdart.dart';

class InheritBloc2 extends BlocBase{
  PublishSubject<List<NumberModel>> _numListStream;
  Observable<List<NumberModel>> get numListObservable => _numListStream.stream;

  PublishSubject<NumberModel> _numStream;
  Observable<NumberModel> get numObservable => _numStream.stream;

  InheritBloc2(){
    _numListStream = new PublishSubject(onListen: () {}, onCancel: () {});
    _numStream = new PublishSubject(onListen: () {}, onCancel: () {});
    List<NumberModel> sampleList = [];
    for(int i= 0; i <= 10; i++){
      sampleList.add(NumberModel(i, false));
    }
  }

  @override
  void dispose() {
    _numListStream.close();
    _numStream.close();
  }
  void changeValue(int number, bool isOn){
    _numStream.sink.add(NumberModel(number, isOn));
    _numListStream.map((item) => item[number].isOn = isOn);
  }

}

class NumberModel{
  int number;
  bool isOn;
  NumberModel(this.number, this.isOn);
}