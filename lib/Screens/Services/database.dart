import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/Models/brew.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  Future updateUser(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set(
      {"sugar": sugars, "name": name, "strength": strength},
    );
  }

  List<Brew> _brewListsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          sugar: doc.get('sugar') ?? '0',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListsnapshot);
  }
}
