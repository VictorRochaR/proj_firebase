import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/item_controller.dart';
import '../models/item.dart';

class EditPage extends StatelessWidget {
  final Item? item;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final ItemController itemController = Get.find();
  final selectedDate = DateTime.now().obs;
  final isGiven = false.obs;

  EditPage({Key? key, this.item}) : super(key: key) {
    if (item != null) {
      descriptionController.text = item!.description;
      // Initialize other fields if item is not null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(item == null ? 'Adicionar iteme' : 'Editar iteme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: recipientController,
              decoration: InputDecoration(labelText: 'Destinatário'),
            ),
            Obx(() => Text(
                'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate.value)}')),
            ElevatedButton(
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate.value) {
                  selectedDate.value = picked;
                }
              },
              child: Text('Selecionar Data'),
            ),
            Obx(() => CheckboxListTile(
                  title: Text('iteme Dado'),
                  value: isGiven.value,
                  onChanged: (bool? value) {
                    if (value != null) {
                      isGiven.value = value;
                    }
                  },
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (item == null) {
                  itemController.addItem(
                      descriptionController.text,
                      selectedDate.value,
                      recipientController.text,
                      isGiven.value);
                } else {
                  itemController.updateItem(
                      item!.id,
                      descriptionController.text,
                      selectedDate.value,
                      recipientController.text,
                      isGiven.value);
                }
                Get.back();
              },
              child: Text(item == null ? 'Adicionar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
