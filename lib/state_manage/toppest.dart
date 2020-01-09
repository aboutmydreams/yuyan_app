import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/state_manage/account/color_manage.dart';
import 'package:yuyan_app/state_manage/account/if_login.dart';
import 'package:yuyan_app/state_manage/dataManage/attent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/select_manage.dart';

class TopStateModel extends Model {
  ColorManage colorManage = ColorManage();
  SelectManage selectManage = SelectManage();
  AttentManage attentManage = AttentManage();

  /// 初始化数据
  void update() {
    attentManage.update();
    // 精选数据
    selectManage.update();
  }
}

TopStateModel topModel = TopStateModel();
// class Name1 extends TopStateModel {}
