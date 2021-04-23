import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';

class CryptoController extends FetchValueController<String> {
  final String cryptText;

  String pwd;

  CryptoController(this.cryptText)
      : super(
          initialState: ViewState.idle,
          initialFetch: false,
        );

  @override
  Future<String> fetch() {
    if (cryptText != null) {
      return ApiRepository.decryptText(text: cryptText, pwd: pwd);
    }
    return null;
  }

  String get errMessage {
    return error.content ?? error.title;
  }
}
