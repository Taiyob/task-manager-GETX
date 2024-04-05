import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/data/models/task_by_status_data.dart';
import 'package:task_manager_application/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager_application/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_application/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_file.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }

  void _getDataFromApi() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
              builder: (countTaskByStatusController){
                return Visibility(
                    visible: countTaskByStatusController.inprogress == false,
                    replacement: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                    child: taskCounterSection(countTaskByStatusController.countByStatusWrapper.listOfTaskByStatusData ?? [],),
                );
              },
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController){
                  return Visibility(
                    visible: newTaskController.inprogress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () async => _getDataFromApi(),
                      child: Visibility(
                        visible: newTaskController.taskListWrapper.taskList?.isNotEmpty ?? false,
                        replacement: const EmptyListWidget(),
                        child: ListView.builder(
                          itemCount: newTaskController.taskListWrapper.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              taskItem: newTaskController.taskListWrapper.taskList![index],
                              refreshList: () {
                                _getDataFromApi();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // // Todo: Recall the home apis after successfully ad new task/tasks
          final result =  Get.to(()=>const AddNewTaskScreen());
          if (result != null && result == true) {
            _getDataFromApi();
          }
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget taskCounterSection(List<TaskByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountByStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
                amount:
                    listOfTaskCountByStatus[index].sum ??
                        0,
                title:
                    listOfTaskCountByStatus[index].sId ??
                        "");
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }
}
