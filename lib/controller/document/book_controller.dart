import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/doc.dart';

class BookDocsController extends FetchListValueController<DocSeri> {
  final int bookId;

  BookDocsController(this.bookId);

  @override
  Future<List<DocSeri>> fetch() {
    return ApiRepository.getBookDocList(bookId: bookId);
  }
}
