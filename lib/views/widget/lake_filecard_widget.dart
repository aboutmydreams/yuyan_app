import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class LakeFileCardWidget extends StatelessWidget {
  final Map json;

  const LakeFileCardWidget({
    Key key,
    @required this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppIcon.iconType('file'),
            ),
            Text(
              '${json['name']}',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Spacer(),
            Text('${json['size']} bytes'),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.download_outlined),
              ),
              onTap: () {
                launch(json['src']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
