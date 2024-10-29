import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/present.dart';

// Controlador para gerenciar o estado dos presentes
class PresentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var presents = <Present>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPresents();
  }

  // Busca os presentes do Firestore e atualiza a lista observável
  void fetchPresents() {
    _firestore.collection('presents').snapshots().listen((snapshot) {
      presents.value = snapshot.docs
          .map((doc) => Present.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Adiciona um novo presente ao Firestore
  Future<void> addPresent(String description, DateTime dateToGive,
      String recipient, bool isGiven) async {
    await _firestore.collection('presents').add({
      'description': description,
      'dateToGive': dateToGive,
      'recipient': recipient,
      'isGiven': isGiven,
    });
    Get.snackbar('Sucesso', 'Presente adicionado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Atualiza um presente existente no Firestore
  Future<void> updatePresent(String id, String description, DateTime dateToGive,
      String recipient, bool isGiven) async {
    await _firestore.collection('presents').doc(id).update({
      'description': description,
      'dateToGive': dateToGive,
      'recipient': recipient,
      'isGiven': isGiven,
    });
    Get.snackbar('Sucesso', 'Presente atualizado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Deleta um presente do Firestore
  Future<void> deletePresent(String id) async {
    await _firestore.collection('presents').doc(id).delete();
    Get.snackbar('Sucesso', 'Presente deletado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }
}
