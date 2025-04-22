
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/registration.dart';
import 'contant_url.dart';
import 'dio_service.dart';

class ApiService {

  ApiService._internal();

  static final _apiService = ApiService._internal();

  factory ApiService() => _apiService;


  static Future<Registration> getRegister(BuildContext context,String lang, String firstname, String lastname,  String emailAddress, String mobileNo,
      String password, String gender, String dob, String relationshipStatus , String  typeOfRelationship , String  currentIntendedOccupation ,
      String academicField , String professionalGoalsProjects , String passwordConfirmation , String  labelOfStudies , String universitySchool , File image) async {
     late Registration registration;
     Dio dio = Dio();
    FormData data = FormData.fromMap({
      "firstname" : firstname,
      "lastname" : lastname,
      "email_address" :  emailAddress,
      "mobile_number" :  mobileNo,
      "password" : password,
      "gender" : gender,
      "date_of_birth" : dob,
      "relationship_status" : relationshipStatus,
      "type_of_relationship" : typeOfRelationship,
      "Current_INtended_occupation" : currentIntendedOccupation,
      "academic_field" : academicField,
      "professional_goals_projects" : professionalGoalsProjects,
      "password_confirmation" : passwordConfirmation,
      "label_of_studies" : labelOfStudies,
      "university_school" : universitySchool,
      "img" : await MultipartFile.fromFile(image.path)
    });

    try{
      final response = await DioService().dio.post(
          data: data,
          ConstantUrl.register,
          options: Options(
            headers: {
              // 'Authorization': 'Bearer $token',
              // 'Content-Type': 'application/json',
            },
          )
      );

      if (response.statusCode == 200){
        registration = Registration.fromJson(response.data);
        return registration;
      }else {
        return Registration(
            errorMsg: 'Api failed with status code : ${response.statusCode}',
            isError: true
        );
      }
    }on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection timeout";
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = "Something went wrong";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Something went wrong";
          break;
        case DioExceptionType.badCertificate:
          errorMessage = "Something went wrong";
          break;
        case DioExceptionType.badResponse:
          errorMessage = "Too many requests retrying...";
          await _retryRequestWithDelay(dio, e.requestOptions, retryAfter: 5);
          break;
        case DioExceptionType.cancel:
          errorMessage = "Something went wrong";
          break;
        case DioExceptionType.connectionError:
          errorMessage = "No internet connection";
          break;
        case DioExceptionType.unknown:
          errorMessage = "No internet connection";
          break;
        default:
          errorMessage = "Something went wrong";
          break;
      }
      return Registration(
        errorMsg: errorMessage,
        isError: true,
      );
    }catch(e){
      return Registration(
        errorMsg: 'An error occurred $e',
        isError: true,
      );
    }
  }

  // static Future<Login> getLogin(BuildContext context,String lang, String email,String password, String deviceToken) async {
  //   late Login login;
  //   Dio dio = Dio();
  //   try {
  //     final response = await DioService().dio.post(
  //         data: {
  //           "lang": lang,
  //           "email": email,
  //           "password": password,
  //           "device_token": deviceToken
  //
  //         },
  //         ConstantUrl.login,
  //         options: Options(
  //           headers: {
  //             // 'Authorization': 'Bearer $token',
  //             // 'Content-Type': 'application/json',
  //           },
  //         )
  //     );
  //
  //     if (response.statusCode == 200) {
  //       login = Login.fromJson(response.data);
  //       if (login.statusCode == 201 && login.status == false) {
  //         return Login(
  //           errorMsg: login.message, // e.g., "Ticket already scanned."
  //           isError: true,
  //         );
  //       }
  //       return login;
  //     } else {
  //       return Login(
  //           errorMsg: 'Api failed with status code : ${response.statusCode}',
  //           isError: true
  //       );
  //     }
  //   }on DioException catch (e) {
  //     String errorMessage;
  //     switch (e.type) {
  //       case DioExceptionType.connectionTimeout:
  //         errorMessage = context.formatString(LocaleData.connection_time_out_txt, ["args"]);
  //         break;
  //       case DioExceptionType.sendTimeout:
  //         errorMessage = context.formatString(LocaleData.something_went_wrong_txt, ["args"]);
  //         break;
  //       case DioExceptionType.receiveTimeout:
  //         errorMessage = context.formatString(LocaleData.something_went_wrong_txt, ["args"]);
  //         break;
  //       case DioExceptionType.badCertificate:
  //         errorMessage = context.formatString(LocaleData.something_went_wrong_txt, ["args"]);
  //         break;
  //       case DioExceptionType.badResponse:
  //         errorMessage = context.formatString(LocaleData.received_invalid_txt, ["args"]);
  //         await _retryRequestWithDelay(dio, e.requestOptions, retryAfter: 5);
  //         break;
  //       case DioExceptionType.cancel:
  //         errorMessage = context.formatString(LocaleData.something_went_wrong_txt, ["args"]);
  //         break;
  //       case DioExceptionType.connectionError:
  //         errorMessage = context.formatString(LocaleData.no_internet_connect_txt, ["args"]);
  //         break;
  //       case DioExceptionType.unknown:
  //         errorMessage = context.formatString(LocaleData.no_internet_connect_txt, ["args"]);
  //         break;
  //       default:
  //         errorMessage = context.formatString(LocaleData.something_went_wrong_txt, ["args"]);
  //         break;
  //     }
  //     return Login(
  //       errorMsg: errorMessage,
  //       isError: true,
  //     );
  //   } catch (e) {
  //     return Login(
  //       errorMsg: 'An error occurred $e',
  //       isError: true,
  //     );
  //   }
  //
  // }

  static Future<void> _retryRequestWithDelay(Dio dio, RequestOptions requestOptions, {int retryAfter = 5}) async {
    await Future.delayed(Duration(seconds: retryAfter)); // Delay before retry
    try {
      Response retryResponse = await dio.request(
        requestOptions.path,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
        ),
      );
      // Handle successful retry
      print(retryResponse.data);
    } catch (retryError) {
      // Handle retry failure
      print("Retry failed: $retryError");
    }
  }

  }