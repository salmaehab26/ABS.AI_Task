import 'package:abs_task/features/auth/model/user.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesFirebase{

  static CollectionReference<NoteModel> getNotesCollection(String uId) {
      return getUsersCollection()
        .doc(uId)
        .collection("Notes")
        .withConverter<NoteModel>(
        fromFirestore: (snapshot, options) =>
            NoteModel.fromJson(snapshot.data()!),
        toFirestore: (note, options) => note.toJson());
  }

  static Future<void> addnoteToFireStore(NoteModel note, String uId) {
    var taskCollection = getNotesCollection(uId);// collection
    var docRef = taskCollection.doc();// document
    note.id = docRef.id;
    return docRef.set(note);
  }

  static Stream<QuerySnapshot<NoteModel>> getNotes( String uId) {
    return getNotesCollection(uId).snapshots();
  }
  static Future<void> updatenote(NoteModel note, String uId) {
    return getNotesCollection(uId).doc(note.id).update(note.toJson());
  }
  static Future<void> deleteNote(String id, String uId) {
    return getNotesCollection(uId).doc(id).delete();
  }
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot, options) =>
            MyUser.fromFireStore(snapshot.data()),
        toFirestore: (user, options) => user.toFireStore());
  }
  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}