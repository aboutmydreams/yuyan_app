import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/doc_detail/doc_detail.dart';

class DocDetailController extends FetchValueController<DocDetailSeri> {
  final int bookId;
  final String slug;

  DocDetailController({this.bookId, this.slug});

  @override
  Future<DocDetailSeri> fetch() {
    return ApiRepository.getDocDetail(bookId: bookId, slug: slug);
  }
}
