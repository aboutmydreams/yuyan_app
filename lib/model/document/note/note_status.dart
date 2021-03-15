import 'package:yuyan_app/model/document/note/note.dart';

class NoteStatusSeri {
  NoteSeri mirror;
  NoteSeri latestNote;

  NoteStatusSeri.fromJson(json) {
    if (json != null) {
      mirror = NoteSeri.fromJson(json['meta']['mirror']);
      latestNote = NoteSeri.fromJson(json['data']['latestNote']);
    }
  }

  Map toJson() => {
        'meta': {
          'mirror': mirror?.toJson(),
        },
        'data': {
          'latestNote': latestNote?.toJson(),
        },
      };
}
