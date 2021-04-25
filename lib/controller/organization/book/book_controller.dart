import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/doc_detail/artboard_seri.dart';
import 'package:yuyan_app/model/document/toc/toc_seri.dart';

class BookTocController extends FetchListValueController<TocSeri> {
  final int bookId;

  BookTocController(this.bookId);

  @override
  Future<List<TocSeri>> fetch() {
    return ApiRepository.getBookTocList(bookId: bookId);
  }
}

class BookDocsController extends FetchListValueController<DocSeri> {
  final int bookId;

  BookDocsController(this.bookId);

  @override
  Future<List<DocSeri>> fetch() {
    return ApiRepository.getBookDocList(bookId: bookId);
  }
}

class BookArtController extends FetchListValueController<ArtboardSeri> {
  final int bookId;

  BookArtController(this.bookId);

  @override
  Future<List<ArtboardSeri>> fetch() {
    return ApiRepository.getBookArtboardList(bookId: bookId);
  }
}
