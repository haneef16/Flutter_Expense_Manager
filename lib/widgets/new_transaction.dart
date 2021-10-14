import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No date chosen!"
                        : "Picked date: ${DateFormat.yMd().format(_selectedDate!)}"),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text("Choose date"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                child: const Text("Add Transaction"),
                onPressed: () {
                  if (double.tryParse(_amountController.text) != null &&
                      double.parse(_amountController.text) < 100 &&
                      _selectedDate != null) {
                    widget.addTx(_titleController.text,
                        double.parse(_amountController.text), _selectedDate);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Container(
//       child: Card(
//         elevation: 2,
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: "Title",
//                 ),
//                 controller: titleController,
//               ),
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: "Amount",
//                 ),
//                 controller: amountController,
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                 child: ElevatedButton(
//                   onPressed: addTx(
//                     titleController.text,
//                     double.parse(amountController.text),
//                   ),
//                   child: const Text("Add Transaction"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     )