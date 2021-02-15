import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests_api/notes/data/note_data.dart';
import 'package:yuyan_app/models/net/requests_api/notes/note.dart';
import 'package:yuyan_app/models/tools/write_json.dart';

class NoteManage extends Model {
  NoteJson _noteData = NoteJson();
  NoteJson get noteData => _noteData;

  getSaveData() async {
    var noteDoc = await readJson('note');
    NoteJson noteData = NoteJson.fromJson(noteDoc);
    _noteData = noteData;
    notifyListeners();
    return noteData;
  }

  saveNoteData() async {
    var dioData = await DioNote.getNotes();
    await writeJson('note', dioData);
    return 1;
  }

  addNote({String html, int id, Function callback}) async {
    var dioData = await DioNote.addNotes(html: html, id: id);
    if (dioData["data"].containsKey("id")) {
      callback();
    }
  }

  void update() {
    saveNoteData().then((res) {
      getSaveData();
    });
  }
}
