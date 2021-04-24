import 'package:bot_toast/bot_toast.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/card/vote_detail.dart';
import 'package:yuyan_app/util/util.dart';

class FollowUserController extends FetchValueController<bool> {
  final int userId;

  FollowUserController({
    this.userId,
    bool isFollow,
  }) : super(
          initialFetch: isFollow == null,
          initValue: isFollow,
          initialState: isFollow == null ? ViewState.loading : ViewState.idle,
        );

  Future<bool> follow() {
    return ApiRepository.followUser(userId: userId);
  }

  Future<bool> unfollow() {
    return ApiRepository.unfollowUser(userId: userId);
  }

  toggle() async {
    try {
      setLoading();
      bool res = false;
      if (this.value) {
        res = await unfollow();
      } else {
        res = await follow();
      }
      if (res) {
        this.value = !value;
        BotToast.showText(text: this.value ? '关注成功' : '取消关注成功');
      } else {
        BotToast.showText(text: '操作失败');
      }
      setIdle();
    } catch (e) {
      BotToast.showText(text: '错误: $e');
      setIdle();
    }
  }

  @override
  Future<bool> fetch() {
    return ApiRepository.getIfFollow(userId: userId);
  }
}

class GroupMarkController extends FetchValueController<bool> {
  final int targetId;

  GroupMarkController({
    this.targetId,
    bool isFollow,
  }) : super(
          initialFetch: isFollow == null,
          initValue: isFollow,
          initialState: isFollow == null ? ViewState.loading : ViewState.idle,
        );

  Future<bool> follow() {
    return ApiRepository.mark(targetId: targetId, targetType: 'User');
  }

  Future<bool> unfollow() {
    return ApiRepository.unmark(targetId: targetId, targetType: 'User');
  }

  toggle() async {
    try {
      setLoading();
      bool res = false;
      if (this.value) {
        res = await unfollow();
      } else {
        res = await follow();
      }
      if (res) {
        this.value = !value;
        BotToast.showText(text: this.value ? '成功' : '取消成功');
      } else {
        BotToast.showText(text: '操作失败');
      }
      setIdle();
    } catch (e) {
      BotToast.showText(text: '错误: $e');
      setIdle();
    }
  }

  @override
  Future<bool> fetch() {
    return ApiRepository.getIfMark(targetId: targetId, targetType: 'User');
  }
}

class VoteController extends FetchValueController<VoteDetailSeri> {
  final int docId;
  final String voteId;
  final List<String> items;
  final String deadline;

  VoteController({this.docId, this.voteId, this.items, this.deadline});

  @override
  Future<VoteDetailSeri> fetch() {
    return ApiRepository.getVoteDetail(
      docId: docId,
      voteId: voteId,
      items: items,
      deadline: deadline,
    );
  }
}

class BookMarkController extends MarkBaseController {
  final int targetId;
  BookMarkController(this.targetId);

  @override
  Future<bool> fetch() {
    return ApiRepository.getIfMark(
      targetId: targetId,
      targetType: 'Book',
    );
  }

  @override
  Future<bool> mark() {
    return ApiRepository.mark(
      targetId: targetId,
      targetType: 'Book',
    );
  }

  @override
  Future<bool> unmark() {
    return ApiRepository.unmark(
      targetId: targetId,
      targetType: 'Book',
    );
  }
}

abstract class MarkBaseController extends FetchValueController<bool> {
  Future<bool> mark();
  Future<bool> unmark();

  @override
  bool get value => super.value ?? false;

  Future toggle() async {
    try {
      setLoading();
      bool res = false;
      if (this.value) {
        res = await unmark();
      } else {
        res = await mark();
      }
      if (res) {
        this.value = !value;
        Util.toast(this.value ? '成功' : '取消成功');
      } else {
        Util.toast('失败');
      }
      setIdle();
    } catch (e) {
      Util.toast('错误: $e');
      setIdle();
    }
  }
}

class BookWatchController extends MarkBaseController {
  final int bookId;

  BookWatchController(this.bookId);

  ActionResultSeri result;

  @override
  Future<bool> fetch() async {
    var res = await ApiRepository.getAction(
      '',
      targetId: bookId,
      actionType: 'watch',
      targetType: 'Book',
    );
    result = ActionResultSeri.fromJson(res.data);
    return result.actioned != null;
  }

  @override
  Future<bool> mark() async {
    var action = await ApiRepository.doAction(
      actionType: 'watch',
      targetId: bookId,
      targetType: 'Book',
    );
    return action != null;
  }

  @override
  Future<bool> unmark() async {
    var action = await ApiRepository.doAction(
      actionType: 'watch',
      targetId: bookId,
      targetType: 'Book',
      del: true,
    );
    return action != null;
  }
}
