import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/item_controller.dart';
import 'edit_page.dart';

class HomePage extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organizador de Presentes')),
      body: Obx(() {
        return ListView.builder(
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              title: Text(item.description),
              subtitle: Text(
                  'Para: ${item.recipient} em ${DateFormat('dd/MM/yyyy').format(item.dateToGive)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.isGiven ? Icons.check : Icons.close),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar Exclusão'),
                            content: Text('Deseja desistir do presente?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  itemController.deleteItem(item.id);
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
                ],
              ),
              onTap: () => Get.to(() => EditPage(item: item)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => EditPage(item: null)),
        child: Icon(Icons.add),
      ),
    );
  }
}
