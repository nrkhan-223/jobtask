import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../models/task_model.dart';
import '../view/add_page.dart';
import '../view/edit_page.dart';


class TaskController extends GetxController {
  List<Task> task = [];
  bool isLoading = true;
  bool isConnected = true;

  get context => BuildContext;

  @override
  void onInit() {
    super.onInit();
    getTask();
  }

  Future<void> getTask() async {
    isLoading = true;
    final response = await Api.getItem(context);
    task = response;
    update();
    isLoading = false;
    update();
  }


  Future<void> deleteTask(id) async {
    await Api.deleteById(id);
    final filterItem = task.where((element) => element.id != id).toList();
    task = filterItem;
    update();
  }

  Future<void> taskCompleted(id, title, desc, isCompleted,context) async {
    await Api.taskCompleted(context, id, title, desc, isCompleted);
    update();
    getTask();
  }

  Future<void> navigate() async {
    await Get.to(() => const AddPage());
    isLoading = true;
    getTask();
    update();
  }

  Future<void> navigate2(
    task,
  ) async {
    await Get.to(() => EditPage(task: task));
    isLoading = true;
    getTask();
    update();
  }
}
