import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

class CreateRegistry extends StatefulWidget {
  static const String routeName = "createRegistry";
  CreateRegistry({super.key});

  @override
  State<CreateRegistry> createState() => _CreateRegistryState();
}

class _CreateRegistryState extends State<CreateRegistry> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _date;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              AppNavigation.goBack();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Create Registry",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // title
              TextFormField(
                controller: _titleEditingController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "Add title here...",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // date
              // TextFormField(
              //   keyboardType: TextInputType.datetime,
              //   decoration: const InputDecoration(
              //     fillColor: Colors.white,
              //     focusColor: Colors.white,
              //     hintText: "Add title here...",
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        dateFormat: 'dd MMMM yyyy',
                        initialDateTime: DateTime.now(),
                        minDateTime: DateTime(DateTime.now().year),
                        maxDateTime: DateTime(3000),
                        onMonthChangeStartWithFirstDate: true,
                        onConfirm: (dateTime, List<int> index) {
                          DateTime selectdate = dateTime;
                          setState(() {
                            _date = selectdate;
                          });
                        },
                      );
                    },
                    child: Icon(
                      Icons.calendar_month,
                      color: _date != null ? Colors.green : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // desc
              TextFormField(
                controller: _descEditingController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "Add description here...",
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter some text';
                  // }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // submit
              ElevatedButton(
                onPressed: () {
                  if (_date == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter Date')),
                    );
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added new registry entry')),
                    );
                    var event = EventModel(
                      id: DateTime.now().toString(),
                      title: _titleEditingController.text,
                      eventDate: _date!,
                      desc: _descEditingController.text,
                    );
                    AppNavigation.pop(event);
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
