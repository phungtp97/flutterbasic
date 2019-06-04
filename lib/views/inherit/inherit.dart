import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasic/base/basebloc.dart';
import 'package:flutterbasic/views/inherit/inheritbloc.dart';

class DemoInheritedWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    InheritBloc mainBloc = new InheritBloc();
    return BlocProvider(
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: AppBar(
          title: BlocProvider(bloc: mainBloc, child: ReactiveAppbar()),
        ),
        body: Center(child: BlocProvider(bloc: mainBloc, child: PassiveChild())),
      ),
    );
  }
}

class ReactiveAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InheritBloc inheritBloc = BlocProvider.of(context);
    inheritBloc.getChatList();
    return StreamBuilder(
        stream: inheritBloc.appBarNameObservable,
        builder: (BuildContext context, snapShot) {
          if (snapShot.hasData) {
            return Text(snapShot.data.toString());
          } else if (!snapShot.hasData) {
            return Text("Loading");
          } else {
            return Text(snapShot.error.toString());
          }
        });
  }
}

class PassiveChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InheritBloc inheritBloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: inheritBloc.appBarNameObservable,
        builder: (BuildContext context, snapShot) {
          if (snapShot.hasData) {
            return Text(snapShot.data.toString());
          } else if (!snapShot.hasData) {
            return Text("Loading");
          } else {
            return Text(snapShot.error.toString());
          }
        });
  }
}

class BuildWithAlertContainer extends StatefulWidget {
  final Widget child;
  final Color initialColor;
  final Color signalColor;

  BuildWithAlertContainer(
      {@required this.child,
      @required this.initialColor,
      @required this.signalColor});

  @override
  State<StatefulWidget> createState() {
    return BuildWithAlertState(child, initialColor, signalColor);
  }
}

class BuildWithAlertState extends State<BuildWithAlertContainer> {
  final Widget child;
  final Color initialColor;
  final Color signalColor;
  Color mainColor;

  BuildWithAlertState(this.child, this.initialColor, this.signalColor);

  @override
  Widget build(BuildContext context) {
    mainColor = signalColor;
    Future.delayed(const Duration(milliseconds: 200), () {
      mainColor = initialColor;
    });

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: this.child,
      color: mainColor,
    );
  }
}
