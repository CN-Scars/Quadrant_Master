import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _launchGithubURL() async {  // 打开Github主页的方法
      const githubUrl = 'https://github.com/CN-Scars';
      if (await canLaunch(githubUrl)) {
        await launch(githubUrl);
      } else {
        launch(githubUrl);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              leading: Icon(MdiIcons.github),
              subtitle: Text('开发者'),
              title: Text('Scars'),
              onTap: _launchGithubURL,
            ),
          ),
        ],
      ),
    );
  }
}
