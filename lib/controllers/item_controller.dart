import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var items = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    _firestore.collection('items').snapshots().listen((snapshot) {
      items.value =
          snapshot.docs.map((doc) => Item.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addItem(String description, DateTime dateToGive,
      String recipient, bool isGiven) async {
    await _firestore.collection('items').add({
      'description': description,
      'dateToGive': dateToGive,
      'recipient': recipient,
      'isGiven': isGiven,
    });
  }

  Future<void> updateItem(String id, String description, DateTime dateToGive,
      String recipient, bool isGiven) async {
    await _firestore.collection('items').doc(id).update({
      'description': description,
      'dateToGive': dateToGive,
      'recipient': recipient,
      'isGiven': isGiven,
    });
  }

  Future<void> deleteItem(String id) async {
    await _firestore.collection('items').doc(id).delete();
  }
}
