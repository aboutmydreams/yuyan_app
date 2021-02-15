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
      "body_asl":
          '<!doctype lake><meta name="doc-version" content="1" /><meta name="viewport" content="adapt" /><meta name="typography" content="classic" /><ul data-lake-id="6ac4bc9e09a780c8d5cd8ff1e047c102"><li data-lake-id="b96287e9cc6375f599fa0d2f8fe99377"><a href="https://github.com/okoala/xque" target="_blank">Xque</a></li><li data-lake-id="ae6cfaa470ae8a170dadf2627e3a7b82"><a href="https://github.com/FEMessage/dique" target="_blank">滴雀<cursor /></a></li></ul><!9d00a136a387377d931c1dd6358d86171a03de498a61ccee34c998d12e635854>',
      "body_html":
          '<div data-placeholder="请输入内容..." class="lake-content-editor-core lake-engine lake-typography-classic" data-lake-element="root" data-selection-undefined="%7B%22path%22%3A%5B%5B0%2C1%2C0%2C0%2C2%5D%2C%5B0%2C1%2C0%2C0%2C2%5D%5D%2C%22active%22%3Atrue%7D"><ul data-lake-id="6ac4bc9e09a780c8d5cd8ff1e047c102" lake-indent="0" style="list-style-type: disc; margin: 0px; padding-left: 23px; font-size: 14px; color: rgb(38, 38, 38); line-height: 1.74; letter-spacing: 0.05em; outline-style: none; overflow-wrap: break-word;"><li data-lake-id="b96287e9cc6375f599fa0d2f8fe99377"><a href="https://github.com/okoala/xque" target="_blank">Xque</a></li><li data-lake-id="ae6cfaa470ae8a170dadf2627e3a7b82"><a href="https://github.com/FEMessage/dique" target="_blank">滴雀</a></li></ul></div><!45e5dd8fb1b02fbe3b2f2d01acf36ac1fc1188adf9910f371985301cbd1503a3>',
      "description":
          '<!doctype lake><meta name="doc-version" content="1" /><meta name="viewport" content="adapt" /><meta name="typography" content="classic" /><ul data-lake-id="6ac4bc9e09a780c8d5cd8ff1e047c102"><li data-lake-id="b96287e9cc6375f599fa0d2f8fe99377"><a href="https://github.com/okoala/xque" target="_blank">Xque</a></li><li data-lake-id="ae6cfaa470ae8a170dadf2627e3a7b82"><a href="https://github.com/FEMessage/dique" target="_blank">滴雀<cursor></cursor></a></li></ul>',
      "has_attachment": false,
      "has_bookmark": false,
      "has_image": false,
      "has_todo": false,
      "save_type": "user"
    };
    var ans = await DioReq.put(url, data: data, onlyUser: true);
    return ans;
  }
}
