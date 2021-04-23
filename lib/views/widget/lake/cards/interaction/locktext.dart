import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/controller/document/crypto_controller.dart';

import '../../widget/card_wrap_widget.dart';

class LakeLockTextWidget extends StatelessWidget {
  final Map json;

  LakeLockTextWidget({
    Key key,
    this.json,
  }) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO(@dreamer2q): 完成功能

    return GetBuilder<CryptoController>(
      tag: json['id'],
      init: CryptoController(json['cryptoData']),
      builder: (c) {
        var locked = json['locked'];
        if (!locked || c.value != null) {
          return LakeCardWrapWidget(
            type: '文本加密',
            child: SelectableText(
              c.value ?? json['originData'],
            ),
          );
        }

        return Container(
          width: Get.width,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/card/lockedtext.png',
                width: 150,
                height: 150,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        controller: _textController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextButton.icon(
                        icon: Icon(Icons.lock_open),
                        label: Text('解锁'),
                        onPressed: () {
                          if (_textController.text == "") {
                            c.setError('请输入密码');
                          } else if (c.state != ViewState.loading) {
                            c.pwd = _textController.text;
                            c.onRefresh(force: true);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (c.state == ViewState.error)
                //display error message
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    '${c.errMessage}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
