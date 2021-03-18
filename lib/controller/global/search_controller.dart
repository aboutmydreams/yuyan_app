import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/search/hits_seri.dart';
import 'package:yuyan_app/model/search/search_result_seri.dart';
import 'package:yuyan_app/util/util.dart';

class SearchQueryEntity {
  String query; //用于去重
  DateTime createdTime; //用于排序

  SearchQueryEntity({
    this.query,
    this.createdTime,
  });

  SearchQueryEntity.fromJson(json) {
    if (json != null) {
      query = json['query'];
      createdTime = DateTime.tryParse(json['createdTime']) ?? DateTime.now();
    }
  }

  Map toJson() => {
        'query': query,
        'createdTime': createdTime.toIso8601String(),
      };
}

class SearchHistoryProvider extends BaseSaveListJson<SearchQueryEntity> {
  @override
  List<SearchQueryEntity> convert(json) {
    var list =
        (json as List).map((e) => SearchQueryEntity.fromJson(e)).toList();
    return list;
  }

  @override
  String get key => 'my_search_history';
}

class SearchController extends FetchListValueController<SearchResultSeri> {
  final String type;

  SearchController({
    this.type,
  }) : super(
          initialState: ViewState.loading,
          initialFetch: false,
        );

  int get totalHits => value.first.totalHits;

  int get numHits => value.map((e) => e.numHits).sum();

  List<SearchHitSeri> get hits =>
      value.map((e) => e.hits).reduce((a, b) => a + b);

  String query;
  bool relateMe;

  int page = 1;

  // onInit(){
  //  super.onInit();
  //
  //  doSearch(text);
  // }

  doSearch(String text, {bool relate = false}) {
    query = text;
    relateMe = relate;
    onRefresh(force: true);
  }

  Future<List<SearchResultSeri>> _fetch(bool more) async {
    if (!more) page = 1;
    var res = await ApiRepository.search(
      query: query,
      type: type,
      page: page,
      relateMe: relateMe,
    );
    if (res.numHits != 0) {
      page++;
    }
    return [res];
  }

  @override
  Future<List<SearchResultSeri>> fetchMore() {
    return _fetch(true);
  }

  @override
  Future<List<SearchResultSeri>> fetch() {
    return _fetch(false);
  }
}
