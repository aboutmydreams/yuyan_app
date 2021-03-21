import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/model/document/note/note_status.dart';
import 'package:yuyan_app/model/document/upload/upload_result_seri.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:yuyan_app/models/component/edit_markdown/convert/to_markdown.dart';

class PostNoteController extends FetchValueController<NoteSeri> {
  final int id;

  PostNoteController(this.id)
      : super(
          initialState: ViewState.idle,
          initialFetch: false,
        );

  Future<bool> postNote(Delta input) async {
    _data = input;
    await this.onRefresh(force: true);
    return state != ViewState.error;
  }

  Delta _data;

  @override
  Future<NoteSeri> fetch() async {
    var mk = NotusMarkdownCodec().encode(_data);
    // NotusMarkdownCodec();
    debugPrint('markdown:\n$mk\n');
    var html = await ApiRepository.convertLake(markdown: mk);
    return ApiRepository.postNote(html: html, id: id);
  }
}

class NoteStatusController extends FetchValueController<NoteStatusSeri> {
  @override
  Future<NoteStatusSeri> fetch() {
    return ApiRepository.getNoteStatus();
  }
}

class ImageUploadController extends FetchValueController<UploadResultSeri> {
  final String asset;
  final int attachId;

  var progress = 0.0.obs;

  ImageUploadController(
    this.asset,
    this.attachId,
  );

  @override
  Future<UploadResultSeri> fetch() {
    return ApiRepository.postNoteImage(
      path: asset,
      attachableId: attachId,
      attachableType: 'Doclet',
      type: 'image',
      progressCallback: _handleProgress,
    );
  }

  _handleProgress(int curr, int total) {
    progress.value = curr / total;
  }
}
