import 'package:dio/dio.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class LecleNetworking {
  static MethodBuilder get(String url) {
    return MethodBuilder(url, Type.GET);
  }

  static MethodBuilder post(String url) {
    return MethodBuilder(url, Type.POST);
  }

  static MethodBuilder put(String url) {
    return MethodBuilder(url, Type.PUT);
  }
}

class ConnectionBuilder {
  Dio dio = new Dio();

  String url;

  Type type;

  bool firstAddPathParameter = true;

  FormData formData = new FormData.from({});

  FormData headers = new FormData.from({});

  ResponseType responseType;

  Map<String, String> httpHeaders;

  int timeOut;

  ConnectionBuilder(
      this.url,
      this.type,
      this.firstAddPathParameter,
      this.formData,
      this.headers,
      this.responseType,
      this.httpHeaders,
      this.timeOut);

  Future<Response<T>> objectObserve<T>() async {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options){
          print("Dio Intercepter: onRequest ${options.toString()}");
          return null;
        },
        onResponse:(Response response) {
          print("Dio Intercepter: onResponse "
              "\nStatus Code: ${response.statusCode.toString()}"
              "\nResponse Type: ${response.data.runtimeType.toString()}"
              "\nHeaders: ${response.headers.toString()}"
              "\nData: ${response.data.toString()}");
          return response;
        },
        onError: (DioError e) {
          print("Dio Intercepter: onError $e");
          return null;
        }
    ));
    
    Response<String> response;

    String method;

    RequestOptions options = new RequestOptions();

    options.headers = httpHeaders;
    options.method = method;
    options.receiveDataWhenStatusError = true;

    switch (type) {
      case Type.POST:
        method = 'POST';
        return await dio.post(url, data: formData, options: options);
        break;
      case Type.GET:
        method = 'GET';
        return await dio.get(url, options: options);
        break;
      case Type.DELETE:
        method = 'DELETE';
        return await dio.delete(url, data: formData, options: options);
        break;
      case Type.PATCH:
        method = 'PATCH';
        return await dio.patch(url, data: formData, options: options);
        break;
      case Type.PUT:
        method = 'PUT';
        return await dio.put(url, data: formData, options: options);
        break;
      default:
        method = 'GET';
        return await dio.get(url, options: options);
        break;
    }
  }
}

class MethodBuilder {
  String url = "";

  Type type = Type.GET;

  bool firstAddPathParameter = true;

  MethodBuilder(this.url, this.type);

  FormData formData = new FormData.from({});

  FormData headers = new FormData.from({});

  ResponseType responseType = ResponseType.json;

  int timeOut = 30000;

  Map<String, String> httpHeaders;

  MethodBuilder addQueryParameter(String key, String value) {
    url = "${url.replaceAll("{$key}", value)}";
    return this;
  }

  MethodBuilder addPathParameter(String key, String value) {
    url = "$url${firstAddPathParameter ? "?" : "&"}$key=$value";
    firstAddPathParameter = false;
    return this;
  }

  MethodBuilder setContentType(String contentType) {
    httpHeaders = {'Content-Type': contentType};
    headers.addAll(httpHeaders);
    return this;
  }

  MethodBuilder setResponseType(ResponseType responseType) {
    this.responseType = responseType;
    return this;
  }

  MethodBuilder addJSONObjectBody(FormData formData) {
    this.formData.addAll(formData);
    return this;
  }

  MethodBuilder addHeaders(FormData header) {
    this.headers.addAll(header);
    return this;
  }

  MethodBuilder setTimeOut(int timeOut) {
    this.timeOut = timeOut;
    return this;
  }

  ConnectionBuilder build() {
    return new ConnectionBuilder(url, type, firstAddPathParameter, formData,
        headers, responseType, httpHeaders, timeOut);
  }
}

enum Type { POST, GET, PUT, DELETE, PATCH }

typedef ResponseCallback = void Function(
    bool hasError, bool hasData, Response response, String error);
