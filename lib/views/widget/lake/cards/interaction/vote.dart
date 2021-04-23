import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/model/document/card/vote_item_seri.dart';
import 'package:yuyan_app/util/util.dart';

import '../../widget/label_widget.dart';

class VoteCardWidget extends StatelessWidget {
  final Map json;
  final int docId;

  const VoteCardWidget({
    Key key,
    this.json,
    this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleVote = (json['type'] == 'single');
    var voteId = json['voteId'];
    var deadline = json['deadline'] as String;
    Get.put(
      VoteController(
        docId: docId,
        voteId: voteId,
        deadline: deadline,
        items: (json['items'] as List)
            .map<String>((e) => e['id'] as String)
            .toList(),
      ),
      tag: voteId,
    );
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _voteTitle(singleVote, json['title']),
          GetBuilder<VoteController>(
            tag: voteId,
            builder: (c) => c.stateBuilder(
              onIdle: () {
                var data = c.value;
                var voteInfo = <String, VoteItemSeri>{};
                var voteMembers = Set<String>();
                var voteLength = 0;
                data.items.forEach((item) {
                  voteInfo[item.id] = item;
                  voteMembers.addAll(item.members);
                });
                voteLength = data.voted.length;
                List children = (json['items'] as List).map((item) {
                  var count = voteInfo[item['id']]?.count ?? 0;
                  var ratio = count / voteLength;
                  return Container(
                    margin: const EdgeInsets.only(top: 8, left: 4, right: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: ListTile(
                      title: _voteTile(item['value'], count, ratio),
                      subtitle: _voteIndicator(ratio),
                      selected: data.voted.contains(item['id']),
                    ),
                  );
                }).toList();
                var over = DateTime.now().difference(deadline.toDateTime()) >
                    const Duration(seconds: 1);
                children.add(Container(
                  child: ListTile(
                    title: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      child: Row(
                        children: [
                          Text('$voteLength 人已投票'),
                          SizedBox(width: 12),
                          Text(over ? '已截至' : '进行中')
                        ],
                      ),
                    ),
                  ),
                ));
                return ListTileTheme(
                  selectedColor: Colors.blue,
                  child: Column(children: children),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _voteTitle(bool singleVote, String title) {
    return Row(
      children: [
        SizedBox(width: 12),
        LabelWidget(
          label: singleVote ? '单选' : '多选',
          colorIndex: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              '$title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _voteIndicator(double value) {
    return LinearProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  _voteTile(String title, int count, double ratio) {
    return Row(
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Text('$title'),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            '$count 票',
            textAlign: TextAlign.end,
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            (ratio * 100).toStringAsFixed(0) + ' %',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
