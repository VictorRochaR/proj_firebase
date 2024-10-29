import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/presentController.dart';
import 'editPage.dart';

// Página inicial que lista os presentes
class HomePage extends StatelessWidget {
  final PresentController presentController = Get.put(PresentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organizador de Presentes')),
      body: Obx(() {
        // Lista de presentes observável
        return ListView.builder(
          itemCount: presentController.presents.length,
          itemBuilder: (context, index) {
            final present = presentController.presents[index];
            return ListTile(
              // Ícone de presente ou cancelamento
              leading: Icon(
                present.isGiven ? Icons.card_giftcard : Icons.cancel,
                color: present.isGiven ? Colors.green : Colors.red,
              ),
              title: Text(present.description),
              subtitle: Text(
                  'Destinatário: ${present.recipient}\nData: ${DateFormat('dd/MM/yyyy').format(present.dateToGive)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Pop up de confirmação para deletar o presente
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar'),
                            content: Text(
                                'Você tem certeza que deseja deletar este presente?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  presentController.deletePresent(present.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => Get.to(() => EditPage(present: present)),
                  ),
                ],
              ),
              // Navega para a página de edição ao tocar no item
              onTap: () => Get.to(() => EditPage(present: present)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        // Navega para a página de adição ao pressionar o botão
        onPressed: () => Get.to(() => EditPage(present: null)),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }
}
