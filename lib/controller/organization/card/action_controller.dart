import 'package:bot_toast/bot_toast.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/card/vote_detail.dart';

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
