import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_artistica/services/auth_service.dart';
import 'package:dio/adapter.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

serviceMethod(
  BuildContext context,
  String method,
  Map<String, dynamic>? data,
  String urlAPI,
  bool token,
  FormData? formData) async {
  final authService = Provider.of<AuthService>(context, listen: false);
  final Map<String, String> headers = {
    "Content-Type"  : "application/json",
  };
  if(token){
    headers["x-token"] = await authService.readAccessToken();
  }
  final options = Options(
    validateStatus: (status) => status! <= 500,
    headers: headers );
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('method $method');
        print('data $data');
        print('urlAPI $urlAPI');
        var _dio = Dio();
        (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
             (HttpClient dioClient) {
           dioClient.badCertificateCallback =
               ((X509Certificate cert, String host, int port) => true);
           return dioClient;
         };
        switch (method) {
          case 'get':
            try{
              return await _dio.get(
                urlAPI,
                options: options)
                  .timeout(const Duration(seconds: 10))
                  .then((value) {
                    print('response.data ${value.data}');
                    print('value.statusCode ${value.statusCode}');
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      default:
                        Navigator.of(context).pop();
                        return callDialogAction(context, json.decode(value.data)['DESCRIPCION']);
                    }
                  }).catchError((err) {
                    print('err $err');
                    Navigator.of(context).pop();
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              Navigator.of(context).pop();
              callDialogAction(context, error.response!.data);
              return null;
            }
          case 'post':
            try{
              return await _dio.post(
                urlAPI,
                data: data,
                options: options)
                  .timeout(const Duration(seconds: 10))
                  .then((value) {
                    print('response.data ${value.data}');
                    print('value.statusCode ${value.statusCode}');
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      case 201:
                        return value;
                      default:
                        Navigator.of(context).pop();
                        return callDialogAction(context, json.decode(value.data)['DESCRIPCION']);
                    }
                  }).catchError((err) {
                    print('err $err');
                    Navigator.of(context).pop();
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              Navigator.of(context).pop();
              return callDialogAction(context, error.response!.data);
            }
          case 'postFile':
            try{
              return await Dio().postUri(
                  Uri.parse(urlAPI),
                  data: formData,
                  options: Options(
                    headers: headers
                  )).timeout(const Duration(milliseconds: 20000))
                  .then((value) {
                    print('response.data ${value.data}');
                    print('value.statusCode ${value.statusCode}');
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      case 201:
                        return value;
                      default:
                        Navigator.of(context).pop();
                        return callDialogAction(context, json.decode(value.data)['DESCRIPCION']);
                    }
                  }).catchError((err) {
                    print('err $err');
                    Navigator.of(context).pop();
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              Navigator.of(context).pop();
              return callDialogAction(context, error.response!.data);
            }
          case 'put':
            try{
              return await _dio.put(
                urlAPI,
                data: data,
                options: options)
                  .timeout(const Duration(seconds: 10))
                  .then((value) {
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      default:
                        callDialogAction(context, value.data);
                        return null;
                    }
                  }).catchError((err) {
                    print('err $err');
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              callDialogAction(context, error.response!.data);
              return null;
            }
          case 'putFile':
            try{
              return await Dio().putUri(
                  Uri.parse(urlAPI),
                  data: formData,
                  options: Options(
                    headers: headers
                  )).timeout(const Duration(milliseconds: 20000))
                  .then((value) {
                    print('response.data ${value.data}');
                    print('value.statusCode ${value.statusCode}');
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      case 201:
                        return value;
                      default:
                        Navigator.of(context).pop();
                        return callDialogAction(context, json.decode(value.data)['DESCRIPCION']);
                    }
                  }).catchError((err) {
                    print('err $err');
                    Navigator.of(context).pop();
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              Navigator.of(context).pop();
              return callDialogAction(context, error.response!.data);
            }
          case 'delete':
            try{
              return await _dio.delete(
                urlAPI,
                options: options)
                  .timeout(const Duration(seconds: 10))
                  .then((value) {
                    switch (value.statusCode) {
                      case 200:
                        return value;
                      default:
                        callDialogAction(context, value.data);
                        return null;
                    }
                  }).catchError((err) {
                    print('err $err');
                    return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
                  });
            } on DioError catch (error) {
              callDialogAction(context, error.response!.data);
              return null;
            }
        }
    }
  } on SocketException catch (e) {
    print('errD $e');
    Navigator.of(context).pop();
    return callDialogAction(context, 'Verifique su conexión a Internet');
  } on TimeoutException catch (e) {
        print('errA $e');
        return callDialogAction(context, 'Lamentamos los inconvenientes, intentalo más tarde');
  }catch (e) {
        print('errC $e');
        return callDialogAction(context, 'Lamentamos los inconvenientes, tenemos problemas con los servidores');
      }
}
