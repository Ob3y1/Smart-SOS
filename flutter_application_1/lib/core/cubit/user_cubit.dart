import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/features/user/UserApp/Complaint.dart';
import 'package:flutter_application_1/features/user/UserApp/home1.dart';
import 'package:flutter_application_1/features/user/UserApp/lasthome.dart';
import 'package:flutter_application_1/features/user/UserApp/model_complaint.dart';
import 'package:flutter_application_1/features/user/UserApp/order.dart';
import 'package:flutter_application_1/features/user/UserApp/user_home_model.dart';
import 'package:flutter_application_1/features/user/home.dart';
import 'package:flutter_application_1/features/user/onbording/content_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/UserApp/model_user.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/core/errors/exeeptions.dart';
import 'package:flutter_application_1/features/user/login/login.dart';
import 'package:flutter_application_1/features/user/login/model.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/features/group/signup/validate_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/cubit/user_state.dart';
import 'package:flutter_map/flutter_map.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumeras api;
  var dio = Dio();
//   sign up username
  TextEditingController userNameController = TextEditingController();
// //log in phone
  TextEditingController controllerPhone = TextEditingController(text: "09");
//   //sign up password
  TextEditingController passwordController = TextEditingController();
//   //sign up config password
  TextEditingController passwordconfigController = TextEditingController();
  TextEditingController edituserNameController = TextEditingController(
    text: prefs.getString("name"),
  );
//log in phone
  TextEditingController editcontrollerPhone = TextEditingController(
    text: prefs.getString("phone_number"),
  );
  String? editcountry = prefs.getString("gender");
  //sign up password
  TextEditingController editpasswordController = TextEditingController();
  //sign up config password
  String tokenGroup = 'Bearer ${prefs.getString("tokenGroup")}';
  UserShow user = UserShow();
  UserHome userHome = UserHome();
//sign up gender
  String? country = "";
  //sign up date
  DateTime date = DateTime.now();
  //log in car_phone
  TextEditingController carController = TextEditingController();
// //log in password car_phone
  TextEditingController carpasswordController = TextEditingController();
//map
  final MapController _mapController = MapController();
  signIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(EndPoints.signIn, data: {
        ApiKey.phone_number: controllerPhone.text,
        ApiKey.password: passwordController.text,
      });

      LoginModel as = LoginModel.fromJson(response);
      print(as.token);
      prefs.setString("token", as.token.toString());
      emit(SignInSuccess());
    } catch (e) {
      print("fsdfsdf");
      emit(const SignInFailure(message: "هناك خطا في عملية التسجيل"));
    }
  }

  getUserProfile() async {
    print("getUserProfile");
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      emit(GetUserLoading());
      final response = await api.get(EndPoints.showProfile, headers: headers);
      user = UserShow.fromJson(response);

      prefs.setString("name", user.user!.name.toString());
      prefs.setString("gender", user.user!.gender.toString());
      prefs.setString("phoneNumber", user.phoneNumber.toString());

      emit(GetUserSuccess());
    } on ServerException catch (e) {
      emit(GetUserFailure(message: e.errorModel.message));
    }
  }

  editUserProfile() async {
    print(prefs.getString("token"));
    try {
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}',
        'Content-Type': 'application/json',
      };
      emit(GetUserLoading());
      final response =
          await api.put(EndPoints.showProfile, headers: headers, data: {
        ApiKey.name: edituserNameController.text,
        // ApiKey.phone_number: editcontrollerPhone.text,
        ApiKey.password: editpasswordController.text,
        ApiKey.date_of_birth: date.toString(),
        ApiKey.gender: editcountry,
      });

      emit(GetUserSuccess());
    } on ServerException catch (e) {
      emit(GetUserFailure(message: e.errorModel.message));
    }
  }

  signIn1() async {
    try {
      emit(SignIn1Loading());
      final response = await api.post(EndPoints.signIn1, data: {
        ApiKey.car_number: carController.text,
        ApiKey.password: carpasswordController.text,
      });
      LoginModel as = LoginModel.fromJson(response);

      prefs.setString("tokenGroup", as.token.toString());
      emit(SignIn1Success());
    } on ServerException catch (e) {
      emit(SignIn1Failure(message: e.errorModel.message));
    } catch (e) {
      print('Unexpected error: $e');
      emit(const SignIn1Failure(message: 'Unexpected error occurred'));
    }
  }

  otp(BuildContext con) async {
    try {
      final response = await api.post(EndPoints.otp,
          data: {ApiKey.phone_number: prefs.getString("controllerPhone")});

      Navigator.pushAndRemoveUntil(
        con,
        MaterialPageRoute(
          builder: (context) => const ValidateCode(),
        ),
        (route) => false,
      );
    } catch (e) {
      print('Unexpected error: $e');
      emit(const OtpFailure(message: 'Unexpected error occurred'));
    }
  }

  signUp(String otp, BuildContext con) async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoints.signup,
        isFromData: true,
        data: {
          ApiKey.name: prefs.getString("userNameController"),
          ApiKey.phone_number: prefs.getString("controllerPhone"),
          ApiKey.date_of_birth: prefs.getString("date"),
          ApiKey.gender: prefs.getString("country"),
          ApiKey.password: prefs.getString("passwordController"),
          ApiKey.otp: otp,
        },
      );
      print("sucscscc");
      Navigator.pushAndRemoveUntil(
        con,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SigUpFailure(message: e.errorModel.message));
    } catch (e) {
      print('Unexpected error: $e');
      emit(const SigUpFailure(message: 'Failed'));
    }
  }

  logout(BuildContext con) async {
    String? token = prefs.getString("token");
    print(token);
    if (token == null) {
      print("Token not found.");
      return;
    }

    print(token);

    var headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await dio.post(
        '${EndPoints.baseUrl}${EndPoints.logout}',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        prefs.clear();
        Navigator.pushAndRemoveUntil(
          con,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      } else {
        print(response.statusMessage ?? 'Unknown error');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  map(String type, String details, BuildContext context) async {
    print("masdsad");
    print(type);
    print(details);
    print(prefs.getString("token"));
    print(prefs.getString("token"));
    print(prefs.getString("latitude"));
    print(prefs.getString("longitude"));
    var headers = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${prefs.getString("token")}',
      'Content-Type': 'application/json'
    };

    var body = {
      "latitude": prefs.getString("latitude"),
      "longitude": prefs.getString("longitude"),
      "type": type,
      "details": details,
    };

    try {
      final response = await dio.post(
        EndPoints.baseUrl + EndPoints.homeuser,
        data: body,
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print("444444444444444444444444444444");

        print('Success: ${response.data["request"]}');
        // prefs.setInt("idUserrequest", response.data["request"]);
        getUserHome(response.data["request"], context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home1(),
            ));
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(
            'DioException: ${e.response!.statusCode} - ${e.response!.statusMessage}');
        print('Response data: ${e.response!.data}');
      } else {
        print('DioException without response: ${e.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> getStatus(int id) async {
    try {
      // إعداد الـ headers
      var headers = {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };

      // إعداد الـ URL

      var url = EndPoints.baseUrl + EndPoints.status;
      // إرسال الطلب باستخدام Dio
      var response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data); // استعراض محتوى الرد
      } else {
        print(response.statusMessage); // طباعة الرسالة في حالة وجود خطأ
      }
    } on DioException catch (e) {
      // التعامل مع الأخطاء في Dio
      if (e.response != null) {
        print(
            'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  void getdetails(BuildContext context) {
    print("getdetails");

    Timer(const Duration(seconds: 0), () async {
      print("22222222222222222222");

      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:5000/get_data'),
        );

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body) as Map<String, dynamic>;
          print(decoded['greetings'] + decoded['greetings2']);
          // استخدم البيانات كما تحتاج
          final greetings = decoded['greetings'];
          final greetings2 = decoded['greetings2'];
          String gree1 = greetings.toString();
          String gree2 = greetings2.toString();

          map(gree1.toString(), gree2, context);
        } else {
          // إذا فشل الطلب، قم بعرض رسالة خطأ
          print('Failed to fetch data: ${response.statusCode}');
        }
      } catch (e) {
        // إذا حدث استثناء، قم بطباعة رسالة الخطأ
        print('Error occurred: $e');
      }
    });
  }

  getUserHome(
    int id,
    BuildContext context,
  ) async {
    Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      emit(UserHomeLoading());
      print("asssss");
      var headers = {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
        'Authorization': 'Bearer ${prefs.getString("token")}',
      };

      var url = '${EndPoints.baseUrl}getrequest/$id';

      try {
        final response = await dio.get(url, options: Options(headers: headers));
        final userHome = UserHome.fromJson(response.data);
        print(response.data);
        if (response.statusCode == 200) {
          emit(UserHomeLoaded(userHome));
        } else if (response.statusCode == 201) {
          print("طبععععععع");
          emit(UserHomeNot());
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const Home(),
          //   ),
          //   (route) => false,
          // );
        } else {
          emit(UserHomeError(response.statusMessage ?? 'Unknown error'));
        }
      } catch (e) {
        emit(UserHomeError(e.toString()));
      }
    });
  }

  Future<void> changeStatus() async {
    var headers = {
      'Authorization': tokenGroup,
    };

    try {
      var response = await dio.request(
        EndPoints.baseUrl + EndPoints.changeStatus,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        getRequestNotification();
        print('Response data: ${json.encode(response.data)}');
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException occurred: ${e.message}');
        print('Response status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Exception occurred: $e');
      }
    }
  }

  Future<void> getRequestNotification() async {
    emit(RequestNotificationLoading());

    print(prefs.getString("tokenGroup"));
    var headers = {
      'Authorization': tokenGroup,
    };

    try {
      var response = await dio.request(
        EndPoints.baseUrl + EndPoints.getRequestNotification,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        // استجابة البيانات هي بالفعل Map، لذا استخدمها مباشرةً
        var data = response.data as Map<String, dynamic>;
        print("eqweqwe");
        emit(RequestNotificationLoaded(data));
      } else if (response.statusCode == 201) {
        print(22222222);
        var data = response.data as Map<String, dynamic>;
        emit(RequestNotificationLoadedNot(data));
      } else {}
    } catch (e) {
      emit(RequestNotificationError(e.toString()));
    }
  }

  agree(String id, BuildContext con) async {
    print(11111111);
    var headers = {
      'Authorization': tokenGroup,
    };

    var response = await dio.request(
      '${EndPoints.baseUrl + EndPoints.agree}/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          con,
          MaterialPageRoute(
            builder: (context) => const lasthome(),
          ));
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  refuse(String id, BuildContext con) async {
    var headers = {
      'Authorization': tokenGroup,
    };

    var response = await dio.request(
      '${EndPoints.baseUrl + EndPoints.refuse}/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      if (json.encode(response.data["success"]) == "true") {
        Navigator.pushReplacement(
            con,
            MaterialPageRoute(
              builder: (context) => const lasthome(),
            ));
      }
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> showInfo(String id) async {
    emit(InfoLoading());

    var headers = {
      'Authorization': tokenGroup,
    };

    try {
      var response = await dio.request(
        "${EndPoints.baseUrl + EndPoints.showInfo}/$id",
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data as Map<String, dynamic>;
        emit(InfoLoaded(data));
      } else {
        emit(InfoError(response.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      emit(InfoError(e.toString()));
    }
  }

  finish(int number, int id, BuildContext con) async {
    print("2131231");
    var headers = {
      'Authorization': tokenGroup,
      'Content-Type': 'application/json'
    };
    var data = json.encode({"false": number, "id": id});
    print(data);
    var response = await dio.request(
      EndPoints.baseUrl + EndPoints.finish,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Navigator.pushAndRemoveUntil(
        con,
        MaterialPageRoute(
          builder: (context) => order(),
        ),
        (route) => false,
      );
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> home() async {
    emit(HomeLoading());

    var headers = {
      'Authorization': tokenGroup,
    };

    try {
      var response = await dio.request(
        EndPoints.baseUrl + EndPoints.home,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data as Map<String, dynamic>;
        emit(HomeLoaded(data['user']));
      } else {
        emit(HomeError(response.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  support(String id) async {
    // Create Dio instance
    emit(InfoLoading());
    // Define the headers
    Map<String, String> headersList = {
      'Authorization': tokenGroup,
    };

    try {
      // Make the GET request
      Response response = await dio.get(
        "${EndPoints.baseUrl + EndPoints.support}/$id",
        options: Options(
          headers: headersList,
        ),
      );

      // Check the status code and print the response body
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        emit(InfoSupport(response.data["message"]));
        print(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  submitComplaint(String ms, BuildContext con) async {
    emit(ComplaintsInitial());

    // Define the headers
    var headersList = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${prefs.getString("token")}',
      'Content-Type': 'application/json',
    };

    // Define the request body
    var body = {
      "message": ms,
    };

    try {
      // Send the POST request
      var response = await dio.post(
        EndPoints.baseUrl + EndPoints.complaints,
        options: Options(headers: headersList),
        data: body,
      );

      // Check the response status
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        emit(ComplaintsSuccess("Complaint submitted successfully."));
        print(response.data);
        Navigator.pushReplacement(
            con,
            MaterialPageRoute(
              builder: (context) => ComplaintsListPage(),
            ));
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchComplaints() async {
    emit(ComplaintsLoading());

    try {
      final response = await dio.get(
        EndPoints.baseUrl + EndPoints.complaints,
        options: Options(headers: {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("token")}',
        }),
      );

      if (response.statusCode == 200) {
        final complaintsResponse = ComplaintsResponse.fromJson(response.data);
        emit(ComplaintsLoaded(complaintsResponse.data));
      } else {
        emit(ComplaintsError('Failed to load data'));
      }
    } catch (e) {
      emit(ComplaintsError('Error: $e'));
    }
  }
}
