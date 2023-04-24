import 'package:flutter/material.dart';
import 'package:quadrant_master/screens/add_task_screen.dart';
import 'package:quadrant_master/screens/completed_tasks_screen.dart';
import 'package:quadrant_master/screens/quadrant_detail_screen.dart';
import 'package:quadrant_master/screens/search_task_screen.dart'; // 新增导入
import 'package:quadrant_master/widgets/quadrant_grid.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController(); // 新增搜索控制器

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('时间四象限'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '菜单',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('已归档任务'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 添加搜索框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索任务',
                hintText: '请输入任务关键词',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              // 当用户提交搜索时，导航到搜索任务页面
              onSubmitted: (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchTaskScreen(query: value),
                  ),
                );
              },
            ),
          ),
          // 展示象限网格
          Expanded(child: QuadrantGrid(
            onTap: (int quadrant) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuadrantDetailScreen(quadrant: quadrant),
                ),
              );
            },
          )),
        ],
      ),
      // 添加一个悬浮按钮，用于导航到添加任务页面
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
