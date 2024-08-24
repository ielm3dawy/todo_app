import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_c11/core/firebase_utils.dart';
import 'package:todo_app_c11/model/task_model.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});

  @override
  State<AddTaskBottomSheetWidget> createState() =>
      _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 30,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add new Task",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 50),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Enter Task Title"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "please enter task title";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: descriptionController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Enter Task Description",
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "please enter task description";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Select Time",
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              geSelectedDate();
            },
            child: Text(
              //selectedDate.toString(),
              DateFormat("dd MMM yyyy").format(selectedDate),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              var taskModel = TaskModel(
                title: titleController.text,
                description: descriptionController.text,
                selectedDate: selectedDate,
              );
              EasyLoading.show();
              FirebaseUtils.addTaskToFirestore(taskModel).then((value) {
                Navigator.pop(context);
                EasyLoading.dismiss();
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "Save",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  geSelectedDate() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}
