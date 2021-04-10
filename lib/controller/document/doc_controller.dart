import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/commen/comment_detail.dart';
import 'package:yuyan_app/model/document/doc_detail/doc_detail.dart';
import 'package:yuyan_app/model/document/user.dart';

class DocDetailController extends FetchValueController<DocDetailSeri> {
  final int bookId;
  final String slug;

  DocDetailController({this.bookId, this.slug});

  @override
  Future<DocDetailSeri> fetch() {
    return ApiRepository.getDocDetail(bookId: bookId, slug: slug);
  }
}

class DocLikesController extends FetchListValueController<UserSeri> {
  final int targetId;

  DocLikesController(this.targetId);

  @override
  Future<List<UserSeri>> fetch() async {
    var data = await ApiRepository.getLikeUsers(targetId: targetId);
    return (data.data as List).map((e) => UserSeri.fromJson(e)).toList();
  }
}

class DocCommentsController extends FetchValueController<ApiResponse> {
  final int commentableId;

  DocCommentsController(this.commentableId);

  List<CommentDetailSeri> comments;

  @override
  Future<ApiResponse> fetch() async {
    var res = await ApiRepository.getComments(
      commentId: commentableId,
      commentType: 'Doc',
    );
    var data = (res.data as List);
    comments = data.map((e) => CommentDetailSeri.fromJson(e)).toList();
    return res;
  }
}
