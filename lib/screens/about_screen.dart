import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 打开Github主页的方法
    _launchGithubURL() async {
      const githubUrl = 'https://github.com/CN-Scars';
      if (await canLaunch(githubUrl)) {
        await launch(githubUrl);
      } else {
        launch(githubUrl);
      }
    }

    // 打开Patreon主页的方法
    _launchPatreonURL () async {
      const patreonUrl = 'https://www.patreon.com/Scars138';
      if (await canLaunch(patreonUrl)) {
        await launch(patreonUrl);
      } else {
        launch(patreonUrl);
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
          Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              leading: Icon(MdiIcons.patreon),
              subtitle: Text('向开发者捐赠以支持开发者'),
              title: Text('Scars'),
              onTap: _launchPatreonURL,
            ),
          ),
        ],
      ),
    );
  }
}
