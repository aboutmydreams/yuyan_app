import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/doc_detail/resource/resource_seri.dart';

class ResourceController extends FetchListValueController<ResourceSeri> {
  final int bookId;
  final int parentId;

  ResourceController(this.bookId, this.parentId);

  @override
  Future<List<ResourceSeri>> fetch() async {
    var asp = await ApiRepository.getResources(
      bookId: bookId,
      parentId: parentId,
    );
    var list = (asp.data as List).map((e) => ResourceSeri.fromJson(e)).toList();
    return list;
  }
}

class ResourceParentController extends FetchListValueController<ResourceSeri> {
  final int resourceId;
  final int level;

  ResourceParentController(
    this.resourceId, {
    this.level = 3,
  });

  @override
  Future<List<ResourceSeri>> fetch() async {
    var asp = await ApiRepository.getResourceParents(
      resourceId: resourceId,
      level: level,
    );
    var data = (asp.data as List).map((e) => ResourceSeri.fromJson(e));
    return data.toList();
  }
}
