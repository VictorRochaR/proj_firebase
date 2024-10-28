import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String description;
  DateTime dateToGive;
  String recipient;
  bool isGiven;

  Item({
    required this.id,
    required this.description,
    required this.dateToGive,
    required this.recipient,
    required this.isGiven,
  });

  factory Item.fromMap(Map<String, dynamic> data, String documentId) {
    return Item(
      id: documentId,
      description: data['description'] ?? '',
      dateToGive: (data['dateToGive'] as Timestamp).toDate(),
      recipient: data['recipient'] ?? '',
      isGiven: data['isGiven'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'dateToGive': dateToGive,
      'recipient': recipient,
      'isGiven': isGiven,
    };
  }
}
