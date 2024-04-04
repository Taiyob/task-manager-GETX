import 'package:get/get.dart';
import 'package:task_manager_application/data/models/login_response.dart';
import 'package:task_manager_application/data/models/response_object.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';

class SignInController extends GetxController{
  bool _inprogress = false;
  String? _errorMessage;
  bool get inprogress {
    return _inprogress;
  }
  String get errorMessage => _errorMessage ?? "Login Failed! Try Again" ;

  Future<bool> signIn(String email, String password) async {
    _inprogress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email" : email,
      "password" : password,
    };
    final ResponseObject response = await NetworkCaller.postRequest(Urls.login, inputParams, fromSignIn: true);
    _inprogress = false;

    if(response.isSuccess){
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(response.responseBody);
      print(loginResponseModel.userData?.firstName);
      await AuthController.saveUserData(loginResponseModel.userData!);
      await AuthController.saveUserToken(loginResponseModel.token!);
      update();
      return true;
    }else{
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}