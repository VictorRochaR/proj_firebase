import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/presentController.dart';
import '../models/present.dart';

// Página de edição/adicionamento de presente
class EditPage extends StatelessWidget {
  final Present? present;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final PresentController presentController = Get.find();
  final selectedDate = DateTime.now().obs;
  final isGiven = false.obs;

  // Construtor da página de edição, inicializa os controladores de texto
  EditPage({Key? key, this.present}) : super(key: key) {
    if (present != null) {
      descriptionController.text = present!.description;
      recipientController.text = present!.recipient;
      selectedDate.value = present!.dateToGive;
      isGiven.value = present!.isGiven;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(present == null ? 'Adicionar Presente' : 'Editar Presente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para a descrição do presente
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição do Presente'),
            ),
            // Campo de texto para o destinatário do presente
            TextField(
              controller: recipientController,
              decoration: InputDecoration(labelText: 'Destinatário'),
            ),
            // Exibição da data selecionada no formato dd/MM/yyyy
            Obx(() => Text(
                'Data de Entrega: ${DateFormat('dd/MM/yyyy').format(selectedDate.value)}')),
            // Botão para selecionar a data
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
                  // Atualiza a data selecionada se o usuário escolher uma nova data
                }
              },
              child: Text('Selecionar Data'),
            ),
            // Checkbox para marcar se o presente foi dado
            Obx(() => CheckboxListTile(
                  title: Text('Presente Entregue'),
                  value: isGiven.value,
                  onChanged: (bool? value) {
                    if (value != null) {
                      isGiven.value = value;
                      // Atualiza o estado do checkbox
                    }
                  },
                )),
            SizedBox(height: 20),
            // Botão para adicionar ou atualizar o presente
            ElevatedButton(
              onPressed: () {
                if (present == null) {
                  presentController.addPresent(
                    descriptionController.text,
                    selectedDate.value,
                    recipientController.text,
                    isGiven.value,
                  );
                } else {
                  presentController.updatePresent(
                    present!.id,
                    descriptionController.text,
                    selectedDate.value,
                    recipientController.text,
                    isGiven.value,
                  );
                }
                Get.back();
                // Retorna para a página anterior após adicionar ou atualizar o presente
              },
              child: Text(present == null ? 'Adicionar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
