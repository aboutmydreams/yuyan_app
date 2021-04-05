import 'package:flutter/material.dart';

class LakeTaskItemWidget extends StatelessWidget {
  final bool value;

  const LakeTaskItemWidget({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox.shrink(
        child: Checkbox(
          value: value,
          onChanged: (v) {
            debugPrint('checkbox: $v');
          },
        ),
      ),
    );
  }
}
