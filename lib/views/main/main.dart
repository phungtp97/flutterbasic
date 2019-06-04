import 'package:flutter/material.dart';
import 'package:flutterbasic/base/basebloc.dart';
import 'package:flutterbasic/db/model.dart';
import 'package:flutterbasic/ui/resource/color.dart';
import 'package:flutterbasic/views/inherit/inherit.dart';
import 'package:flutterbasic/views/inherit2/inherit.dart';
import 'package:flutterbasic/views/main/testblocbasic.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Basic'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocProvider(bloc: BlocBasic(), child: BlocWidget()),
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Inherit2(
                  );
                }));
              },
              child: Container(child:
                Text('Demo Bloc with inheritedWidget')
              ),
              highlightColor: ResourceColor.primary,
              splashColor: ResourceColor.darkPrimary,
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class BlocWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocBasic blocBasic = BlocProvider.of(context);

    return FlatButton(
      onPressed: () {
        blocBasic.getSampleUser();
      },
      child: Container(
        child: StreamBuilder(
          stream: blocBasic.userObservable,
          builder: (BuildContext context, snapShot) {
            if(snapShot.hasData ){
              switch(snapShot.connectionState){
                case ConnectionState.none:
                  return Text("");
                  break;
                case ConnectionState.done:
                  return Text("");
                  break;
                case ConnectionState.waiting:
                  return Text("Click to call User");
                  break;
                case ConnectionState.active:
                  if(snapShot.data is User) {
                    return Text((snapShot.data as User).id);
                  }
                  else{
                    return Text("Api data error");
                  }
                  break;
                default:
                  return Text("Click to call User");
              }
            }
            else{
              return Text(snapShot.error.toString());
            }
          },
        ),
      ),
      highlightColor: ResourceColor.primary,
      splashColor: ResourceColor.darkPrimary,
      padding: EdgeInsets.all(10),
    );
  }
}
