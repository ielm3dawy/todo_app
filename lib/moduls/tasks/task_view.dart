import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_c11/core/firebase_utils.dart';
import 'package:todo_app_c11/model/task_model.dart';
import 'package:todo_app_c11/moduls/tasks/widget/task_item_widget.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 20,
                    right: 20,
                  ),
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.2,
                  color: theme.primaryColor,
                  child: Text(
                    "To Do List",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: mediaQuery.size.width,
                ),
              ],
            ),
            Positioned(
              top: 130,
              child: SizedBox(
                width: mediaQuery.size.width,
                child: EasyInfiniteDateTimeLine(
                  controller: _controller,
                  firstDate: DateTime(2024),
                  focusDate: _focusDate,
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  onDateChange: (selectedDate) {
                    setState(() {
                      _focusDate = selectedDate;
                      print(_focusDate);
                    });
                  },
                  showTimelineHeader: false,
                  timeLineProps: const EasyTimeLineProps(separatorPadding: 10),
                  dayProps: EasyDayProps(
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseUtils.getRealTimeDataFromFirestore(_focusDate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Somthing went wrong",
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }
                List<TaskModel> tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) => TaskItemWidget(
                    taskModel: tasksList[index],
                  ),
                  itemCount: tasksList.length,
                );
              }),
        ),
      ],
    );
  }
}
