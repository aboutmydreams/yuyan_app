import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LakeLockTextWidget extends StatelessWidget {
  final Map json;

  const LakeLockTextWidget({
    Key key,
    this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(12),
        child: Builder(
          builder: (_) {
            if (json['locked'] == false) {
              return Container(
                child: Text(
                  '${json['originData']}',
                ),
              );
            }
            return Container(
              child: Text('请输入密码解密！'),
            );
          },
        ),
      ),
    );
  }
}
