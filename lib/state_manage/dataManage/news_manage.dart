import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

class NewsManage extends Model {
  int page = 1;
  SelectionsData _selectData = SelectionsData(data: []);
  SelectionsData get selecData => _selectData;

  getSaveData() async {
    var selectDoc = await readJson('select');
    SelectionsData selectionsData = SelectionsData.fromJson(selectDoc);
    _selectData = selectionsData;
    notifyListeners();
    return selectionsData;
  }

  getMoreData() async {
    page += 1;
    var dioData = await DioReq.get("/explore/selections?limit=1&page=$page");
    SelectionsData selectionsData = SelectionsData.fromJson(dioData);
    _selectData.data.addAll(selectionsData.data);
  }

  saveSelecData() async {
    var dioData = await DioReq.get("/notifications/unread-count");
    await writeJson('unread_count', dioData);
    return 1;
  }

  void update() {
    saveSelecData().then((res) {
      getSaveData();
    });
  }
}
