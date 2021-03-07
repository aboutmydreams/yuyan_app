import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';

class FollowUserController extends GetxController with ControllerStateMixin {
  final int userId;

  bool _followed;

  bool get followed => _followed;

  FollowUserController({
    this.userId,
    bool isFollow,
  }) : _followed = isFollow {
    if (_followed == null) {
      initState(ViewState.loading);
      init();
    }
  }

  init() async {
    safeHandler(() async {
      _followed = await ApiRepository.getIfFollow(userId: userId);
    });
  }

  Future<bool> follow() {
    return ApiRepository.followUser(userId: userId);
  }

  Future<bool> unfollow() {
    return ApiRepository.unfollowUser(userId: userId);
  }

  toggle() async {
    try {
      setLoading();
      if (_followed) {
        await unfollow();
        _followed = false;
        BotToast.showText(text: '取消关注成功');
      } else {
        await follow();
        _followed = true;
        BotToast.showText(text: '关注成功');
      }
      setIdle();
    } catch (e) {
      BotToast.showText(text: '错误: $e');
      setIdle();
    }
  }
}
