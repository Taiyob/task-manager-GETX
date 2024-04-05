import 'package:get/get.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';

class NewTaskController extends GetxController {
  TaskListWrapper _taskListWrapper = TaskListWrapper();
  bool _inprogress = false;
  String? _errorMessage;
  TaskListWrapper get taskListWrapper => _taskListWrapper;
  bool get inprogress {
    return _inprogress;
  }
  String get errorMessage => _errorMessage ?? "Fetch count by task status failed" ;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inprogress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if(response.isSuccess){
      _taskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    }else{
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();
    return isSuccess;
  }
}