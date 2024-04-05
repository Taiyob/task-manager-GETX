import 'package:get/get.dart';
import 'package:task_manager_application/data/models/count_by_status_wrapper.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';

class CountTaskByStatusController extends GetxController {
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  bool _inprogress = false;
  String? _errorMessage;
  CountByStatusWrapper get countByStatusWrapper => _countByStatusWrapper;
  bool get inprogress {
    return _inprogress;
  }
  String get errorMessage => _errorMessage ?? "Fetch count by task status failed" ;

  Future<bool> getCountByTaskStatus() async {
    bool isSuccess = false;
    _inprogress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    if(response.isSuccess){
      _countByStatusWrapper = CountByStatusWrapper.fromJson(response.responseBody);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();
    return isSuccess;
  }
}