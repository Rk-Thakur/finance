import 'package:finance/calculationprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class finance extends StatefulWidget {
  const finance({Key? key}) : super(key: key);

  @override
  State<finance> createState() => _financeState();
}

class _financeState extends State<finance> {
  List<String> items = ['PVIF', 'PVIFA', 'FVIF', 'FVIFA'];
  String? selectedItem = 'PVIF';
  final interestController = TextEditingController();
  final yearController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Finance"),
          leading: Icon(Icons.eco_outlined),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final cal = ref.watch(calculationprovider);
            final total = ref
                .watch(calculationprovider)
                .calculatedValue
                .toStringAsFixed(4);
            return Form(
              key: _form,
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          controller: interestController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Interest is required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Interest',
                              hintText: 'Input the Interest',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          controller: yearController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Year is required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Year',
                              hintText: 'Input the year',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                labelText: "Choose one of these",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.red))),
                            value: selectedItem,
                            items: items
                                .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )))
                                .toList(),
                            onChanged: (item) => setState(() {
                                  selectedItem = item;
                                })),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 240,
                        child: Center(
                            child: Text(
                          total.toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              ref.read(calculationprovider).calculation(
                                  interest:
                                      double.parse(interestController.text),
                                  year: double.parse(yearController.text),
                                  type: selectedItem.toString());
                            }
                          },
                          child: Text("Check"))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
