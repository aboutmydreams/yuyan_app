import 'package:yuyan_app/models/net/requests/dio_requests.dart';

class DioNote {
  // 获取语雀小记
  static getNotes({String text: '', String type: 'all', int offset: 0}) async {
    var url = "/notes?filter_type=$type&offset=$offset&q=$text";
    var ans = await DioReq.get(url, onlyUser: true);
    return ans;
    // return NoteJson.fromJson(ans);
  }

  // 添加语雀小记
  static addNotes({String html, int id: 0, String type: 'all'}) async {
    var url = "/notes/$id";
    var data = {
      "body_asl": html,
      "body_html": html,
      "description": html,
      "has_attachment": false,
      "has_bookmark": false,
      "has_image": html.contains('name="image"'),
      "has_todo": html.contains('name="checkbox"'),
      "save_type": "user"
    };
    var ans = await DioReq.put(url, data: data, onlyUser: true);
    return ans;
  }
}
