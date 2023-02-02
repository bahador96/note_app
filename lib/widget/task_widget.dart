// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/task.dart';
import 'package:flutter_application_1/screens/edit_task_screen.dart';

// import 'package:msh_checkbox/msh_checkbox.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _getMainContent(),
        ),
      ),
    );
  }

  Widget _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      value: isBoxChecked,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      onChanged: (isChecked) {},
                    ),
                  ),
                  Text(widget.task.title),
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _getTimeAndEditBadgs(),
            ],
          ),
        ),
        // Spacer(),
        const SizedBox(
          width: 20,
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Row _getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 90,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                  task: widget.task,
                ),
              ),
            );
          },
          child: Container(
            width: 95,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xffE2F6F1),
              // color: Colors.black,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'ویرایش',
                    style: TextStyle(
                      // color: Color(0xff18DAA3),
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'images/icon_edit.png',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
