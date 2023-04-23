import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _quadrant = 1;
  DateTime _dueDate = DateTime.now();
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _quadrant = widget.task.quadrant;
    _dueDate = widget.task.dueDate;
    _priority = widget.task.priority;
  }

  void _submitTask(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      quadrant: _quadrant,
      dueDate: _dueDate,
      priority: _priority,
      isCompleted: widget.task.isCompleted,
    );

    Provider.of<TasksProvider>(context, listen: false).updateTask(updatedTask);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑任务'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ... 其他表单控件，
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: '任务标题'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入任务标题';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: '任务描述'),
              ),
              DropdownButtonFormField<int>(
                value: _quadrant,
                items: List.generate(4, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('象限 ${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _quadrant = value!;
                  });
                },
                decoration: InputDecoration(labelText: '选择象限'),
              ),
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem<TaskPriority>(
                    value: priority,
                    child: Text(priority.toShortString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                decoration: InputDecoration(labelText: '选择优先级'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dueDate = selectedDate;
                    });
                  }
                },
                child:
                    Text('选择截止日期：${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _submitTask(context),
                child: Text('保存修改'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
