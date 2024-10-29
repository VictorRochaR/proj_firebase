import 'package:cloud_firestore/cloud_firestore.dart';

// Criação do Construtor de presentes
class Present {
  String id;
  String description;
  DateTime dateToGive;
  String recipient;
  bool isGiven;

  Present({
    required this.id,
    required this.description,
    required this.dateToGive,
    required this.recipient,
    required this.isGiven,
  });

  factory Present.fromMap(Map<String, dynamic> data, String documentId) {
    return Present(
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
