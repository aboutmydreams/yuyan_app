import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
// import 'data/convert_json.dart';

class DioUtil {
  // 获取语雀小记
  static toLake({@required String markdown, @required String referer}) async {
    /// [referer] like this 'https://www.yuque.com/dashboard/notes'
    var url = "/docs/convert";
    var ctoken = await getCtoken();
    Map postData = {
      'from': 'markdown',
      'to': 'lake',
      'content': markdown,
      'ctoken': ctoken
    };

    var ans = await DioReq.post(url, data: postData, headers: {
      'add': {'referer': referer}
    });
    // return ConvertJson.fromJson(ans);
    return ans['data'];
  }
}
