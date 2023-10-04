import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/user/user_profile_update/register_function_prov.dart';

class OptionTextField extends StatelessWidget {
  const OptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterDetailsForm>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Gender';
                        } else {
                          return null;
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      value: value.selectedOption,
                      items: value.options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        value.setSelectedOptionGender(newValue!);
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25),
                        labelText: 'Select Gender',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select Gender';
                          } else {
                            return null;
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        value: value.selectedOption,
                        items: value.options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          value.setSelectedOptionGender(newValue!);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Gender',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
