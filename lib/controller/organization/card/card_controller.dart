import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/card/card_video_info_seri.dart';

class CardVideoController extends FetchValueController<CardVideoResSeri> {
  final String videoId;

  CardVideoController(this.videoId);

  @override
  Future<CardVideoResSeri> fetch() {
    return ApiRepository.getCardVideo(videoId: videoId);
  }
}
