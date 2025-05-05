import 'package:abs_task/features/auth/model/user.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeFirebase {
   CollectionReference<NoteModel> getNotesCollection(String uId) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("Notes")
        .withConverter<NoteModel>(
      fromFirestore: (snapshot, _) => NoteModel.fromJson(snapshot.data()!),
      toFirestore: (note, _) => note.toJson(),
    );
  }

   Future<void> addnoteToFireStore(NoteModel note, String uId) async {
    var taskCollection = getNotesCollection(uId);
    var docRef = taskCollection.doc();
    note.id = docRef.id;
    await docRef.set(note);
  }

   Stream<QuerySnapshot<NoteModel>> getNotes(String uId) {
    return getNotesCollection(uId).snapshots();
  }
  //
  //  Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotes() {
  //   return FirebaseFirestore.instance.collectionGroup("Notes").snapshots();
  // }


   Future<void> updatenote(NoteModel note, String uId) {
    return getNotesCollection(uId).doc(note.id).update(note.toJson());
  }
   Future<void> deleteNote(String id, String uId) {
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