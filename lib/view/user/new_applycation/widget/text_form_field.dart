import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/user/user_profile_update/register_function_prov.dart';
import 'package:shorinryu/view/user/new_applycation/widget/option_text_field.dart';

// ignore: must_be_immutable
class TextFormFieldFormUpdate extends StatelessWidget {
  const TextFormFieldFormUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterDetailsForm>(
      builder: (context, value, child) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              controller: value.candidateNameController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    'Candidate Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Name';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              controller: value.addressController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    'Address',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Address';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              controller: value.postOfficeController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    ' Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Enter Post Office',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Post';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: value.pinNumberController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    ' Pin Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Enter Pin Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Pin Number';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 12,
              controller: value.proofNumberConroller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    'Aadhar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: ' Aadhar',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Aadhar Number';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: value.contactNumberController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    ' Contact Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Contact  Number';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: value.alternateNumberController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    ' Alternate Contact Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Enter Alternate Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Alternate Number';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: TextFormField(
              controller: value.dateInputController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2101),
                );

                value.updateSelectedDate(pickedDate!);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  suffixIcon: const Icon(Icons.calendar_today),
                  label: const Text(
                    'Date Of Birth',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Select Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter DOB';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 2,
              controller: value.ageController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    'Candidate Age',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Enter Age',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Age';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: TextFormField(
              controller: value.parentsNameController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  label: const Text(
                    'Guardian Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Guardian Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Enter Guardian Name';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: value.parentsNumberController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25),
                  label: const Text(
                    'Guardian Contact Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  hintText: 'Guardian Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter contact';
                } else {
                  return null;
                }
              },
            ),
          ),
          const OptionTextField(),
        ],
      ),
    );
  }
}
