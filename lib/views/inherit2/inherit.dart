import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasic/base/basebloc.dart';

import 'inheritbloc2.dart';

class Inherit2 extends StatelessWidget {
  final InheritBloc2 _inheritBloc2 = new InheritBloc2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo Inherit"),
        ),
        body: Center(
          child: BlocProvider(
            bloc: _inheritBloc2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: <Widget>[
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(1, true);
                        }, number: 1),
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(2, true);
                        }, number: 2),
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(3, true);
                        }, number: 3),
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(4, true);
                        }, number: 4),
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(5, true);
                        }, number: 5),
                        BlocButtonWidget(voidCallback: (){
                          _inheritBloc2.changeValue(6, true);
                        }, number: 6),
                      ],
                    )),
                BlocWidgetLevel1(),
              ],
            ),
          ),
        ));
  }
}

class BlocButtonWidget extends StatelessWidget {
  VoidCallback voidCallback;
  int number;

  BlocButtonWidget({@required this.voidCallback,@required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      child: IconButton(icon: Text("$number"), onPressed: voidCallback, color: Colors.grey,iconSize: 30,),
    );
  }
}

class BlocWidgetLevel1 extends StatelessWidget {
  InheritBloc2 _inheritBloc2;
  bool mIsOn = false;

  @override
  Widget build(BuildContext context) {
    _inheritBloc2 = BlocProvider.of(context);
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: _inheritBloc2.numObservable,
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              if ((snapShot.data as NumberModel).number == 1) {
                mIsOn = (snapShot.data as NumberModel).isOn;
                return SquareBlock(1, mIsOn);
              } else {
                return SquareBlock(1, mIsOn);
              }
            } else {
              return SquareBlock(1, false);
            }
          },
        ),
        BlocWidgetLevel2()
      ],
    );
  }
}

class BlocWidgetLevel2 extends StatelessWidget {
  InheritBloc2 _inheritBloc2;
  bool mIsOn1 = false;
  bool mIsOn2 = false;
  @override
  Widget build(BuildContext context) {
    _inheritBloc2 = BlocProvider.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _inheritBloc2.numObservable,
              builder: (BuildContext context, snapShot) {
                if (snapShot.hasData) {
                  if ((snapShot.data as NumberModel).number == 2) {
                    mIsOn1 = (snapShot.data as NumberModel).isOn;
                    return SquareBlock(2, mIsOn1);
                  } else {
                    return SquareBlock(2, mIsOn1);
                  }
                } else {
                  return SquareBlock(2, false);
                }
              },
            ),
            StreamBuilder(
              stream: _inheritBloc2.numObservable,
              builder: (BuildContext context, snapShot) {
                if (snapShot.hasData) {
                  if ((snapShot.data as NumberModel).number == 3) {
                    mIsOn2 = (snapShot.data as NumberModel).isOn;
                    return SquareBlock(3, mIsOn2);
                  } else {
                    return SquareBlock(3, mIsOn2);
                  }
                } else {
                  return SquareBlock(3, false);
                }
              },
            ),
          ],
        ),
        BlocWidgetLevel3()
      ],
    );
  }
}

class BlocWidgetLevel3 extends StatelessWidget {
  InheritBloc2 _inheritBloc2;
  bool mIsOn1 = false;
  bool mIsOn2 = false;
  bool mIsOn3 = false;

  @override
  Widget build(BuildContext context) {
    _inheritBloc2 = BlocProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StreamBuilder(
          stream: _inheritBloc2.numObservable,
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              if ((snapShot.data as NumberModel).number == 4) {
                mIsOn1 = (snapShot.data as NumberModel).isOn;
                return SquareBlock(4, mIsOn1);
              } else {
                return SquareBlock(4, mIsOn1);
              }
            } else {
              return SquareBlock(4, false);
            }
          },
        ),
        StreamBuilder(
          stream: _inheritBloc2.numObservable,
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              if ((snapShot.data as NumberModel).number == 5) {
                mIsOn2 = (snapShot.data as NumberModel).isOn;
                return SquareBlock(5, mIsOn2);
              } else {
                return SquareBlock(5, mIsOn2);
              }
            } else {
              return SquareBlock(5, false);
            }
          },
        ),
        StreamBuilder(
          stream: _inheritBloc2.numObservable,
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              if ((snapShot.data as NumberModel).number == 6) {
                mIsOn3 = (snapShot.data as NumberModel).isOn;
                return SquareBlock(6, mIsOn3);
              } else {
                return SquareBlock(6, mIsOn3);
              }
            } else {
              return SquareBlock(6, false);
            }
          },
        ),
      ],
    );
  }
}

class SquareBlock extends StatelessWidget {
  bool isOn = false;
  final int number;

  SquareBlock(this.number, this.isOn);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.all(10),
      duration: Duration(milliseconds: 500),
      decoration: new BoxDecoration(
          color: isOn ? Colors.green : Colors.grey,
          border: new Border.all(
              color: Colors.black87, width: 2, style: BorderStyle.solid)),
      height: 80,
      width: 80,
      alignment: FractionalOffset.center,
      child: new Text(
        "$number",
        style: TextStyle(
            color: isOn ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
