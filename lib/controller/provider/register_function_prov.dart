import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';

class RegisterDetailsForm extends ChangeNotifier {
  File? image;

  File? fileImage;
  String? value;

  get path => null;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final phototemp = File(photo.path);
      fileImage = phototemp;
      notifyListeners();
    }
  }

  final TextEditingController candidateNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postOfficeController = TextEditingController();
  final TextEditingController pinNumberController = TextEditingController();
  final TextEditingController proofNumberConroller = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController alternateNumberController =
      TextEditingController();
  TextEditingController _dateInputController = TextEditingController();
  TextEditingController get dateInputController => _dateInputController;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController parentsNameController = TextEditingController();
  final TextEditingController parentsNumberController = TextEditingController();

  clearFormData() async {
    fileImage = null;
    candidateNameController.clear();
    addressController.clear();
    postOfficeController.clear();
    pinNumberController.clear();
    proofNumberConroller.clear();
    alternateNumberController.clear();
    contactNumberController.clear();
    dateInputController.clear();
    ageController.clear();
    parentsNameController.clear();
    parentsNumberController.clear();
  }

  List<String> options = ['male', 'female'];
  String? selectedOption;

  void setSelectedOptionGender(String newValue) {
    selectedOption = newValue;
    notifyListeners();
  }

  List<String> marriegeStatus = ['True', 'False'];
  String? selectedstatus;

  void selectStatus(String newStatus) {
    selectedstatus = newStatus;
    notifyListeners();
  }

  Future<void> updateFormRegister(context) async {
    await registerUserForm(fileImage, selectedstatus, selectedOption, context);
  }

  Future<void> registerUserForm(
      File? image, String? gender, String? marriegeStatus, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId').toString();
    final accessKey = prefs.getString('accessKey').toString();

    print(gender);
    print(marriegeStatus);
    print(accessKey);
    print(id);

    try {
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse("$baseUrl/user/update/"),
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessKey',
      });
      if (image != null) {
        var pic = await http.MultipartFile.fromPath(
          "profile_picture",
          fileImage!.path,
        );
        request.files.add(pic);
      }

      request.fields.addAll({
        'id': id,
        "name": candidateNameController.text,
        'date_of_birth': dateInputController.text,
        'number': contactNumberController.text,
        'alternate_number': alternateNumberController.text,
        'guardian_contact_number': parentsNumberController.text,
        // "gender": gender.toString(),
        'guardian_name': parentsNameController.text,
        // 'married': marriegeStatus.toString(),
        'address': addressController.text,
        'pincode': pinNumberController.text,
        'post': postOfficeController.text,
        'aadhar_number': proofNumberConroller.text,
        // 'is_form_filled': "true"
      });
      StreamedResponse res = await request.send();

      if (res.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Registration Successful'),
          ),
        );

        print('success');
      } else {
        print('errrorr');
      }
    } catch (e) {
      return;
    }
  }

  String _selectedDate = "";

  dateInputProvider() {
    _dateInputController.text = _selectedDate;
  }

  String get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime pickedDate) {
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _selectedDate = formattedDate;
    } else {
      _selectedDate = "Date is not selected";
    }
    _dateInputController.text = _selectedDate;
    notifyListeners();
  }
}
