import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c18/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class EventService {
  static CollectionReference<EventModel> _getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection("events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  static Future<String?> createNewEvent(EventModel event) async {
    try {
      CollectionReference<EventModel> collection = _getEventsCollection();
      DocumentReference<EventModel> doc = collection.doc();
      event.id = doc.id;
      await doc.set(event);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static deleteEvent(String eventId) {}
  static editEvent(EventModel event) {}

  static Future<List<EventModel>> getAllEvents() async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshots = await collection.get();
    List<QueryDocumentSnapshot<EventModel>> docs = snapshots.docs;
    List<EventModel> events = docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<List<EventModel>> getFilteredEvents(int id) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshots = await collection.where("catId", isEqualTo: id).get();
    List<QueryDocumentSnapshot<EventModel>> docs = snapshots.docs;
    List<EventModel> events = docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<List<EventModel>> getWishlistEvents() async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshots = await collection
        .where("wishlist", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<QueryDocumentSnapshot<EventModel>> docs = snapshots.docs;
    List<EventModel> events = docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<void> addToWishlist(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    List<String> wishlist = event.wishlist ?? [];
    if (wishlist.contains(FirebaseAuth.instance.currentUser!.uid)) {
      await removeFromWishlist(event);
      return;
    }
    wishlist.add(FirebaseAuth.instance.currentUser!.uid);

    DocumentReference<EventModel> doc = collection.doc(event.id);

    await doc.update({'wishlist': wishlist});
  }

  static Future removeFromWishlist(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    List<String> wishlist = event.wishlist ?? [];
    wishlist.remove(FirebaseAuth.instance.currentUser!.uid);

    DocumentReference<EventModel> doc = collection.doc(event.id);

    await doc.update({'wishlist': wishlist});
  }
}
