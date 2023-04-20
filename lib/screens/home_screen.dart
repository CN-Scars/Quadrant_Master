import 'package:flutter/material.dart';
import 'package:quadrant_master/screens/add_task_screen.dart';
import 'package:quadrant_master/screens/quadrant_detail_screen.dart';
import 'package:quadrant_master/widgets/quadrant_grid.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('时间四象限'),
      ),
      body: QuadrantGrid(
        onTap: (int quadrant) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuadrantDetailScreen(quadrant: quadrant),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
