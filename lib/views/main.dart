import 'package:flutter/material.dart';
import 'package:flutterbasic/base/basebloc.dart';
import 'package:flutterbasic/db/model.dart';
import 'package:flutterbasic/ui/resource/color.dart';
import 'package:flutterbasic/views/testblocbasic.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
            BlocProvider(bloc: BlocBasic(), child: BlocWidget())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          initialData: Colors.red,
          stream: blocBasic.dataStream,
          builder: (BuildContext context, snapShot) {
            if(snapShot.hasData){
              if(snapShot.data is User) {
                return Text((snapShot.data as User).id);
              }
              else{
                return Text("Click to get User");
              }
            }
            else{
              return Text(snapShot.data.runtimeType.toString());
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
