import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/model/watchlist_model.dart';

class FirebaseFunctions {
  static CollectionReference<WatchListModel> getMovieWatchListCollection() {
    return FirebaseFirestore.instance.collection('WatchList').withConverter(
          fromFirestore: (snapshot, options) =>
              WatchListModel.fromJson(snapshot.data()),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addMovieToFire(WatchListModel watchListModel) {
    var collection = getMovieWatchListCollection();
    var docRef = collection.doc(watchListModel.id.toString());
    return docRef.set(watchListModel);
  }

  static Stream<QuerySnapshot<WatchListModel>> getMoviesFormFire() {
    var collection = getMovieWatchListCollection();
    return collection.snapshots();
  }

  static Future<void> deleteMovie(String id) {
    var collection = getMovieWatchListCollection();
    return collection.doc(id).delete();
  }
  static Future<bool> searchMovieById(String id) async{
    var snapshot= await getMovieWatchListCollection().doc(id).get();
    return snapshot.exists;
  }
}
