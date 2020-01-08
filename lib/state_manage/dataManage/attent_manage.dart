import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

class AttentManage extends Model {
  int offset = 0;
  AttentData _attentData = AttentData(data: []);
  AttentData get selecData => _attentData;

  getSaveData() async {
    var selectDoc = await readJson('events');
    AttentData attentionData = AttentData.fromJson(selectDoc);
    _attentData = attentionData;
    notifyListeners();
    return attentionData;
  }

  getMoreData() async {
    var dioData = await DioReq.get("/events?offset=$offset");
    AttentData attentionData = AttentData.fromJson(dioData);
    offset = attentionData.offset;
    _attentData.data.addAll(attentionData.data);
  }

  saveEventsData() async {
    var dioData = await DioReq.get("/events?offset=0");
    offset = dioData["offset"];
    await writeJson('events', dioData);
    return 1;
  }

  void update() {
    saveEventsData().then((res) {
      getSaveData();
    });
  }
}
