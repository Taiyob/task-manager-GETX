import 'package:get/get.dart';
import 'package:task_manager_application/data/models/response_object.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';

class SignUpController extends GetxController{
  bool _inprogress = false;
  String? _errorMessage;
  bool get inprogress {
    return _inprogress;
  }
  String get errorMessage => _errorMessage ?? "Registration Failed, Try Again" ;

  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {
    _inprogress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    final ResponseObject response =
    await NetworkCaller.postRequest(Urls.registration, inputParams);
    _inprogress = false;

    if (response.isSuccess) {
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}