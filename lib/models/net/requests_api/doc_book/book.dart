import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/data/doc_book_data.dart';

class DioDocBook {
  // 文档知识库
  static getData({int bookId}) async {
    var res = await DioReq.get(
        "/books/$bookId/docs?include_contributors=true&include_hits=true&limit=200&offset=0");
    DocBookJson theData = DocBookJson.fromJson(res);
    return theData;
  }
}
