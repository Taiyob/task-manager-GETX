import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager_application/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager_application/presentation/controllers/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignInController());
    Get.put(SignUpController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
  }
}