import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasic/base/basebloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterbasic/db/model.dart';

class InheritBloc extends BlocBase {
  PublishSubject<List<Chat>> _chatListStream;

  PublishSubject<List<OptionDescription>> _optionsListStream;

  PublishSubject<String> _appBarNameStream;

  InheritBloc() {
    _chatListStream = new PublishSubject(onListen: () {}, onCancel: () {});
    _optionsListStream = new PublishSubject(onListen: () {}, onCancel: () {});
    _appBarNameStream = new PublishSubject(onListen: () {}, onCancel: () {});
  }

  Observable<List<Chat>> get chatListObservable => _chatListStream.stream;

  Observable<List<OptionDescription>> get optionListObservable =>
      _optionsListStream.stream;

  Observable<String> get appBarNameObservable => _appBarNameStream.stream;

  @override
  void dispose() {
    _chatListStream.close();
    _optionsListStream.close();
    _appBarNameStream.close();
  }

  void getChatList() async {
    Error error = new StateError("Api error");
    appRepo.getChatList().then((response) => {
          if (response.statusCode == 200)
            {
              _onGetChatListSuccess(Chat.fromJsonList(response.data))
            }
          else
            {_chatListStream.sink.addError(error)}
        });
  }

  void _onGetChatListSuccess(List<Chat> chats) {
    Future.delayed(Duration(milliseconds: 1000), () {
      _appBarNameStream.sink.add("Reactive Appbar");
    });
    _chatListStream.sink.add(chats);
  }

  void getOptionList() async {
    List<OptionDescription> fullOptionList = [];
    fullOptionList.add(OptionDescription(Icons.image));
    fullOptionList.add(OptionDescription(Icons.share));
    fullOptionList.add(OptionDescription(Icons.people));
    fullOptionList.add(OptionDescription(Icons.video_call));
    fullOptionList.add(OptionDescription(Icons.attach_file));

    Random rnd;
    int min = 2;
    int max = 5;
    rnd = new Random();
    List<OptionDescription> randomOptionList = [];
    int numberOfOptions = min + rnd.nextInt(max - min);
    for (var i = 0; i < numberOfOptions; i++) {
      randomOptionList.add(fullOptionList[i]);
    }
    _optionsListStream.sink.add(randomOptionList);
  }
}

class OptionDescription {
  IconData icon;

  OptionDescription(this.icon);
}
