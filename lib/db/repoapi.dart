import 'package:dio/dio.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

abstract class RepoApi{
  Future<Response> getUser();
}