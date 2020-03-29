import 'package:yuyan_app/state_manage/account/color_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/attent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/news_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/quick_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/recent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/select_manage.dart';
import 'package:yuyan_app/state_manage/version_manage/version_manage.dart';

import 'layout_manage/hide_bottom.dart';

class TopStateModel extends ColorManage {
  // ColorManage colorManage = ColorManage();
  BottomManage bottomManage = BottomManage();

  SelectManage selectManage = SelectManage();
  AttentManage attentManage = AttentManage();
  NewsManage newsManage = NewsManage();
  QuickManage quickManage = QuickManage();
  RecentManage recentManage = RecentManage();
  MyInfoManage myInfoManage = MyInfoManage();
  VersionManage versionManage = VersionManage();

  /// 初始化数据
  void update() {
    // 检查更新
    versionManage.initAll();
    // 关注数据
    attentManage.update();
    // 精选数据
    selectManage.update();
    // 快捷入口
    quickManage.update();
    // 最近数据
    recentManage.update();
    // 消息数据
    newsManage.update();
    // 我的数据
    myInfoManage.update();
  }
}

TopStateModel topModel = TopStateModel();

// class Name1 extends TopStateModel {}
