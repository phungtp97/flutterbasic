import 'package:flutterbasic/db/remote/apiendpoint.dart';
import 'package:flutterbasic/db/remote/networking.dart';
import 'package:flutterbasic/db/repoapi.dart';
import 'package:dio/dio.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class AppRepo implements RepoApi {

  @override
  Future<Response> getUser() async {
    Response response = await LecleNetworking.get(ApiEndPoint.SAMPLE_USER_API)
        .addQueryParameter("samplepath", "cfWObmFQia")
        .addPathParameter("indent", "2")
        .setContentType("application/json")
        .build()
        .objectObserve();
    return response;
  }

  @override
  Future<Response> getChatList() async {
    Response response = await LecleNetworking.get(ApiEndPoint.SAMPLE_USER_API)
        .addQueryParameter("samplepath", "bUlafmCZlu")
        .addPathParameter("indent", "2")
        .setContentType("application/json")
        .build()
        .objectObserve();
    return response;
  }
}
