import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:docx_template_fork/docx_template_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_field_widget.dart';
import 'package:file_selector/file_selector.dart';

void main() {
  runApp(const WordFillerApp());
}

class WordFillerApp extends StatelessWidget {
  const WordFillerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Controllers for founder (người thành lập)
  final _founderNameController = TextEditingController();
  final _founderBirthDateController = TextEditingController();
  final _founderGenderController = TextEditingController();
  final _founderIdController = TextEditingController();
  final _founderAddressController = TextEditingController();
  final _founderHouseNumberController = TextEditingController();
  final _founderWardController = TextEditingController();
  final _founderProvinceController = TextEditingController();
  final _founderCountryController = TextEditingController();
  final _founderPhoneController = TextEditingController();
  final _founderEmailController = TextEditingController();

  // Controllers for owner (chủ sở hữu)
  final _ownerOwnerNameController = TextEditingController();
  final _ownerOwnerBirthDateController = TextEditingController();
  final _ownerOwnerGenderController = TextEditingController();
  final _ownerOwnerIdController = TextEditingController();
  final _ownerOwnerAddressController = TextEditingController();
  final _ownerOwnerHouseNumberController = TextEditingController();
  final _ownerOwnerWardController = TextEditingController();
  final _ownerOwnerProvinceController = TextEditingController();
  final _ownerOwnerCountryController = TextEditingController();
  final _ownerOwnerPhoneController = TextEditingController();
  final _ownerOwnerEmailController = TextEditingController();

  // Controllers for general director (tổng giám đốc)
  final _directorNameController = TextEditingController();
  final _directorBirthDateController = TextEditingController();
  final _directorGenderController = TextEditingController();
  final _directorIdController = TextEditingController();
  final _directorAddressController = TextEditingController();
  final _directorHouseNumberController = TextEditingController();
  final _directorWardController = TextEditingController();
  final _directorProvinceController = TextEditingController();
  final _directorCountryController = TextEditingController();
  final _directorPhoneController = TextEditingController();
  final _directorEmailController = TextEditingController();

  // Controllers for legal representative (người đại diện pháp luật)
  final _legalRepNameController = TextEditingController();
  final _legalRepBirthDateController = TextEditingController();
  final _legalRepGenderController = TextEditingController();
  final _legalRepIdController = TextEditingController();
  final _legalRepAddressController = TextEditingController();
  final _legalRepHouseNumberController = TextEditingController();
  final _legalRepWardController = TextEditingController();
  final _legalRepProvinceController = TextEditingController();
  final _legalRepCountryController = TextEditingController();
  final _legalRepPhoneController = TextEditingController();
  final _legalRepEmailController = TextEditingController();
  final _legalRepPositionController = TextEditingController();

  // New controllers for company information
  final _companyNameController = TextEditingController();
  final _companyVietnameseNameController = TextEditingController();
  final _companyForeignNameController = TextEditingController();
  final _companyAbbreviationController = TextEditingController();
  final _companyHouseNumberController = TextEditingController();
  final _companyWardController = TextEditingController();
  final _companyProvinceController = TextEditingController();
  final _companyCountryController = TextEditingController();
  final _companyPhoneController = TextEditingController();
  final _companyFaxController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _companyWebsiteController = TextEditingController();

  // New controllers for capital information
  final _capitalNumberController = TextEditingController();
  final _capitalTextController = TextEditingController();

  // New controllers for detailed capital information
  final _stateBudgetCapitalController = TextEditingController();
  final _privateCapitalController = TextEditingController();
  final _foreignCapitalController = TextEditingController();
  final _otherCapitalController = TextEditingController();
  final _totalCapitalController = TextEditingController();

  // New controllers for contributed assets
  final _vndAssetsController = TextEditingController();
  final _foreignCurrencyAssetsController = TextEditingController();
  final _goldAssetsController = TextEditingController();
  final _landUseRightsController = TextEditingController();
  final _intellectualPropertyController = TextEditingController();
  final _otherAssetsController = TextEditingController();
  final _totalContributedAssetsController = TextEditingController();

  // New controllers for business sector information
  final _businessNameController = TextEditingController();
  final _businessCodeController = TextEditingController();
  bool _isMainBusiness = false;

  // List to store business sectors
  final List<Map<String, dynamic>> _businessSectors = [];

  // Controllers for select boxes
  String? _founderApplyFrom;
  String? _ownerApplyFrom;
  String? _directorApplyFrom;
  String? _legalRepApplyFrom;

  // Store original values before applying information
  Map<String, String> _originalFounderValues = {};
  Map<String, String> _originalOwnerValues = {};
  Map<String, String> _originalDirectorValues = {};
  Map<String, String> _originalLegalRepValues = {};

  @override
  void initState() {
    super.initState();

    // Initialize founder information with sample data
    _founderNameController.text = "Nguyễn Văn A";
    _founderBirthDateController.text = "15/03/1980";
    _founderGenderController.text = "Nam";
    _founderIdController.text = "123456789012";
    _founderAddressController.text = "123 Đường ABC";
    _founderHouseNumberController.text = "123";
    _founderWardController.text = "Phường 1";
    _founderProvinceController.text = "TP. Hồ Chí Minh";
    _founderCountryController.text = "Việt Nam";
    _founderPhoneController.text = "0901234567";
    _founderEmailController.text = "nguyenvana@email.com";

    // Initialize owner information with sample data
    _ownerOwnerNameController.text = "Trần Thị B";
    _ownerOwnerBirthDateController.text = "20/07/1975";
    _ownerOwnerGenderController.text = "Nữ";
    _ownerOwnerIdController.text = "987654321098";
    _ownerOwnerAddressController.text = "456 Đường XYZ";
    _ownerOwnerHouseNumberController.text = "456";
    _ownerOwnerWardController.text = "Phường 2";
    _ownerOwnerProvinceController.text = "Hà Nội";
    _ownerOwnerCountryController.text = "Việt Nam";
    _ownerOwnerPhoneController.text = "0912345678";
    _ownerOwnerEmailController.text = "tranthib@email.com";

    // Initialize general director information with sample data
    _directorNameController.text = "Lê Văn C";
    _directorBirthDateController.text = "10/12/1985";
    _directorGenderController.text = "Nam";
    _directorIdController.text = "456789123012";
    _directorAddressController.text = "789 Đường DEF";
    _directorHouseNumberController.text = "789";
    _directorWardController.text = "Phường 3";
    _directorProvinceController.text = "Đà Nẵng";
    _directorCountryController.text = "Việt Nam";
    _directorPhoneController.text = "0923456789";
    _directorEmailController.text = "levanc@email.com";

    // Initialize legal representative information with sample data
    _legalRepNameController.text = "Phạm Thị D";
    _legalRepBirthDateController.text = "25/09/1970";
    _legalRepGenderController.text = "Nữ";
    _legalRepIdController.text = "789123456012";
    _legalRepAddressController.text = "321 Đường GHI";
    _legalRepHouseNumberController.text = "321";
    _legalRepWardController.text = "Phường 4";
    _legalRepProvinceController.text = "Cần Thơ";
    _legalRepCountryController.text = "Việt Nam";
    _legalRepPhoneController.text = "0934567890";
    _legalRepEmailController.text = "phamthid@email.com";
    _legalRepPositionController.text = "Giám đốc";

    // Initialize company information with sample data
    _companyNameController.text = "Công ty TNHH ABC";
    _companyVietnameseNameController.text = "Công ty Trách nhiệm Hữu hạn ABC";
    _companyForeignNameController.text = "ABC Company Limited";
    _companyAbbreviationController.text = "ABC Co., Ltd";
    _companyHouseNumberController.text = "100";
    _companyWardController.text = "Phường 5";
    _companyProvinceController.text = "TP. Hồ Chí Minh";
    _companyCountryController.text = "Việt Nam";
    _companyPhoneController.text = "02812345678";
    _companyFaxController.text = "02812345679";
    _companyEmailController.text = "info@abc.com.vn";
    _companyWebsiteController.text = "www.abc.com.vn";

    // Initialize capital information with sample data
    _capitalNumberController.text = "10,000,000,000";
    _capitalTextController.text = "Mười tỷ đồng";

    // Initialize detailed capital information with sample data
    _stateBudgetCapitalController.text = "0";
    _privateCapitalController.text = "8,000,000,000";
    _foreignCapitalController.text = "2,000,000,000";
    _otherCapitalController.text = "0";
    _totalCapitalController.text = "10,000,000,000";

    // Initialize contributed assets with sample data
    _vndAssetsController.text = "6,000,000,000";
    _foreignCurrencyAssetsController.text = "2,000,000,000";
    _goldAssetsController.text = "0";
    _landUseRightsController.text = "1,500,000,000";
    _intellectualPropertyController.text = "500,000,000";
    _otherAssetsController.text = "0";
    _totalContributedAssetsController.text = "10,000,000,000";

    // Initialize business sector information with sample data
    _businessNameController.text = "Thương mại điện tử";
    _businessCodeController.text = "4791";
    _businessSectors.add({
      'name': _businessNameController.text,
      'code': _businessCodeController.text,
      'isMain': _isMainBusiness,
    });
    _isMainBusiness = true;
  }

  // Method to add new business sector
  void _addBusinessSector() {
    if (_businessNameController.text.isNotEmpty &&
        _businessCodeController.text.isNotEmpty) {
      setState(() {
        _businessSectors.add({
          'name': _businessNameController.text,
          'code': _businessCodeController.text,
          'isMain': _isMainBusiness,
        });

        // Clear the input fields
        _businessNameController.clear();
        _businessCodeController.clear();
        _isMainBusiness = false;
      });
    }
  }

  // Method to remove business sector
  void _removeBusinessSector(int index) {
    setState(() {
      _businessSectors.removeAt(index);
    });
  }

  // Method to edit business sector
  void _editBusinessSector(int index) {
    Map<String, dynamic> sector = _businessSectors[index];
    _businessNameController.text = sector['name'];
    _businessCodeController.text = sector['code'];
    _isMainBusiness = sector['isMain'];

    // Show dialog to edit the business sector
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa ngành nghề'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _businessNameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên ngành nghề',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _businessCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Mã ngành',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _isMainBusiness,
                        onChanged: _businessSectors.where((sector) => sector != _businessSectors[index]).any((sector) => sector['isMain'] == true) && !_isMainBusiness
                            ? null // Disable if another sector is already main
                            : (value) {
                                setDialogState(() {
                                  _isMainBusiness = value ?? false;
                                });
                              },
                      ),
                      Text(
                        "Ngành nghề kinh doanh chính",
                        style: TextStyle(
                          color: _businessSectors.where((sector) => sector != _businessSectors[index]).any((sector) => sector['isMain'] == true) && !_isMainBusiness
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear the input fields
                _businessNameController.clear();
                _businessCodeController.clear();
                _isMainBusiness = false;
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (_businessNameController.text.isNotEmpty &&
                    _businessCodeController.text.isNotEmpty) {
                  setState(() {
                    _businessSectors[index] = {
                      'name': _businessNameController.text,
                      'code': _businessCodeController.text,
                      'isMain': _isMainBusiness,
                    };
                  });
                  Navigator.of(context).pop();
                  // Clear the input fields
                  _businessNameController.clear();
                  _businessCodeController.clear();
                  _isMainBusiness = false;
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

    // Method to store original values before applying information
  void _storeOriginalValues(String targetRole) {
    switch (targetRole) {
      case 'founder':
        _originalFounderValues = {
          'name': _founderNameController.text,
          'birthDate': _founderBirthDateController.text,
          'gender': _founderGenderController.text,
          'id': _founderIdController.text,
          'address': _founderAddressController.text,
          'houseNumber': _founderHouseNumberController.text,
          'ward': _founderWardController.text,
          'province': _founderProvinceController.text,
          'country': _founderCountryController.text,
          'phone': _founderPhoneController.text,
          'email': _founderEmailController.text,
        };
        break;
      case 'owner':
        _originalOwnerValues = {
          'name': _ownerOwnerNameController.text,
          'birthDate': _ownerOwnerBirthDateController.text,
          'gender': _ownerOwnerGenderController.text,
          'id': _ownerOwnerIdController.text,
          'address': _ownerOwnerAddressController.text,
          'houseNumber': _ownerOwnerHouseNumberController.text,
          'ward': _ownerOwnerWardController.text,
          'province': _ownerOwnerProvinceController.text,
          'country': _ownerOwnerCountryController.text,
          'phone': _ownerOwnerPhoneController.text,
          'email': _ownerOwnerEmailController.text,
        };
        break;
      case 'director':
        _originalDirectorValues = {
          'name': _directorNameController.text,
          'birthDate': _directorBirthDateController.text,
          'gender': _directorGenderController.text,
          'id': _directorIdController.text,
          'address': _directorAddressController.text,
          'houseNumber': _directorHouseNumberController.text,
          'ward': _directorWardController.text,
          'province': _directorProvinceController.text,
          'country': _directorCountryController.text,
          'phone': _directorPhoneController.text,
          'email': _directorEmailController.text,
        };
        break;
      case 'legalRep':
        _originalLegalRepValues = {
          'name': _legalRepNameController.text,
          'birthDate': _legalRepBirthDateController.text,
          'gender': _legalRepGenderController.text,
          'id': _legalRepIdController.text,
          'address': _legalRepAddressController.text,
          'houseNumber': _legalRepHouseNumberController.text,
          'ward': _legalRepWardController.text,
          'province': _legalRepProvinceController.text,
          'country': _legalRepCountryController.text,
          'phone': _legalRepPhoneController.text,
          'email': _legalRepEmailController.text,
        };
        break;
    }
  }

  // Method to restore original values
  void _restoreOriginalValues(String targetRole) {
    setState(() {
      switch (targetRole) {
        case 'founder':
          if (_originalFounderValues.isNotEmpty) {
            _founderNameController.text = _originalFounderValues['name'] ?? '';
            _founderBirthDateController.text = _originalFounderValues['birthDate'] ?? '';
            _founderGenderController.text = _originalFounderValues['gender'] ?? '';
            _founderIdController.text = _originalFounderValues['id'] ?? '';
            _founderAddressController.text = _originalFounderValues['address'] ?? '';
            _founderHouseNumberController.text = _originalFounderValues['houseNumber'] ?? '';
            _founderWardController.text = _originalFounderValues['ward'] ?? '';
            _founderProvinceController.text = _originalFounderValues['province'] ?? '';
            _founderCountryController.text = _originalFounderValues['country'] ?? '';
            _founderPhoneController.text = _originalFounderValues['phone'] ?? '';
            _founderEmailController.text = _originalFounderValues['email'] ?? '';
          }
          break;
        case 'owner':
          if (_originalOwnerValues.isNotEmpty) {
            _ownerOwnerNameController.text = _originalOwnerValues['name'] ?? '';
            _ownerOwnerBirthDateController.text = _originalOwnerValues['birthDate'] ?? '';
            _ownerOwnerGenderController.text = _originalOwnerValues['gender'] ?? '';
            _ownerOwnerIdController.text = _originalOwnerValues['id'] ?? '';
            _ownerOwnerAddressController.text = _originalOwnerValues['address'] ?? '';
            _ownerOwnerHouseNumberController.text = _originalOwnerValues['houseNumber'] ?? '';
            _ownerOwnerWardController.text = _originalOwnerValues['ward'] ?? '';
            _ownerOwnerProvinceController.text = _originalOwnerValues['province'] ?? '';
            _ownerOwnerCountryController.text = _originalOwnerValues['country'] ?? '';
            _ownerOwnerPhoneController.text = _originalOwnerValues['phone'] ?? '';
            _ownerOwnerEmailController.text = _originalOwnerValues['email'] ?? '';
          }
          break;
        case 'director':
          if (_originalDirectorValues.isNotEmpty) {
            _directorNameController.text = _originalDirectorValues['name'] ?? '';
            _directorBirthDateController.text = _originalDirectorValues['birthDate'] ?? '';
            _directorGenderController.text = _originalDirectorValues['gender'] ?? '';
            _directorIdController.text = _originalDirectorValues['id'] ?? '';
            _directorAddressController.text = _originalDirectorValues['address'] ?? '';
            _directorHouseNumberController.text = _originalDirectorValues['houseNumber'] ?? '';
            _directorWardController.text = _originalDirectorValues['ward'] ?? '';
            _directorProvinceController.text = _originalDirectorValues['province'] ?? '';
            _directorCountryController.text = _originalDirectorValues['country'] ?? '';
            _directorPhoneController.text = _originalDirectorValues['phone'] ?? '';
            _directorEmailController.text = _originalDirectorValues['email'] ?? '';
          }
          break;
        case 'legalRep':
          if (_originalLegalRepValues.isNotEmpty) {
            _legalRepNameController.text = _originalLegalRepValues['name'] ?? '';
            _legalRepBirthDateController.text = _originalLegalRepValues['birthDate'] ?? '';
            _legalRepGenderController.text = _originalLegalRepValues['gender'] ?? '';
            _legalRepIdController.text = _originalLegalRepValues['id'] ?? '';
            _legalRepAddressController.text = _originalLegalRepValues['address'] ?? '';
            _legalRepHouseNumberController.text = _originalLegalRepValues['houseNumber'] ?? '';
            _legalRepWardController.text = _originalLegalRepValues['ward'] ?? '';
            _legalRepProvinceController.text = _originalLegalRepValues['province'] ?? '';
            _legalRepCountryController.text = _originalLegalRepValues['country'] ?? '';
            _legalRepPhoneController.text = _originalLegalRepValues['phone'] ?? '';
            _legalRepEmailController.text = _originalLegalRepValues['email'] ?? '';
          }
          break;
      }
    });
  }

  // Method to apply information from one person to another
  void _applyInformation(String targetRole, String? sourceRole) {
    if (sourceRole == null) {
      // If null is selected, restore original values
      _restoreOriginalValues(targetRole);
      return;
    }
    
    // Store original values before applying new ones
    _storeOriginalValues(targetRole);
    
    setState(() {
      switch (targetRole) {
        case 'founder':
          switch (sourceRole) {
            case 'owner':
              _founderNameController.text = _ownerOwnerNameController.text;
              _founderBirthDateController.text =
                  _ownerOwnerBirthDateController.text;
              _founderGenderController.text = _ownerOwnerGenderController.text;
              _founderIdController.text = _ownerOwnerIdController.text;
              _founderAddressController.text =
                  _ownerOwnerAddressController.text;
              _founderHouseNumberController.text =
                  _ownerOwnerHouseNumberController.text;
              _founderWardController.text = _ownerOwnerWardController.text;
              _founderProvinceController.text =
                  _ownerOwnerProvinceController.text;
              _founderCountryController.text =
                  _ownerOwnerCountryController.text;
              _founderPhoneController.text = _ownerOwnerPhoneController.text;
              _founderEmailController.text = _ownerOwnerEmailController.text;
              break;
            case 'director':
              _founderNameController.text = _directorNameController.text;
              _founderBirthDateController.text =
                  _directorBirthDateController.text;
              _founderGenderController.text = _directorGenderController.text;
              _founderIdController.text = _directorIdController.text;
              _founderAddressController.text = _directorAddressController.text;
              _founderHouseNumberController.text =
                  _directorHouseNumberController.text;
              _founderWardController.text = _directorWardController.text;
              _founderProvinceController.text =
                  _directorProvinceController.text;
              _founderCountryController.text = _directorCountryController.text;
              _founderPhoneController.text = _directorPhoneController.text;
              _founderEmailController.text = _directorEmailController.text;
              break;
            case 'legalRep':
              _founderNameController.text = _legalRepNameController.text;
              _founderBirthDateController.text =
                  _legalRepBirthDateController.text;
              _founderGenderController.text = _legalRepGenderController.text;
              _founderIdController.text = _legalRepIdController.text;
              _founderAddressController.text = _legalRepAddressController.text;
              _founderHouseNumberController.text =
                  _legalRepHouseNumberController.text;
              _founderWardController.text = _legalRepWardController.text;
              _founderProvinceController.text =
                  _legalRepProvinceController.text;
              _founderCountryController.text = _legalRepCountryController.text;
              _founderPhoneController.text = _legalRepPhoneController.text;
              _founderEmailController.text = _legalRepEmailController.text;
              break;
          }
          break;
        case 'owner':
          switch (sourceRole) {
            case 'founder':
              _ownerOwnerNameController.text = _founderNameController.text;
              _ownerOwnerBirthDateController.text =
                  _founderBirthDateController.text;
              _ownerOwnerGenderController.text = _founderGenderController.text;
              _ownerOwnerIdController.text = _founderIdController.text;
              _ownerOwnerAddressController.text =
                  _founderAddressController.text;
              _ownerOwnerHouseNumberController.text =
                  _founderHouseNumberController.text;
              _ownerOwnerWardController.text = _founderWardController.text;
              _ownerOwnerProvinceController.text =
                  _founderProvinceController.text;
              _ownerOwnerCountryController.text =
                  _founderCountryController.text;
              _ownerOwnerPhoneController.text = _founderPhoneController.text;
              _ownerOwnerEmailController.text = _founderEmailController.text;
              break;
            case 'director':
              _ownerOwnerNameController.text = _directorNameController.text;
              _ownerOwnerBirthDateController.text =
                  _directorBirthDateController.text;
              _ownerOwnerGenderController.text = _directorGenderController.text;
              _ownerOwnerIdController.text = _directorIdController.text;
              _ownerOwnerAddressController.text =
                  _directorAddressController.text;
              _ownerOwnerHouseNumberController.text =
                  _directorHouseNumberController.text;
              _ownerOwnerWardController.text = _directorWardController.text;
              _ownerOwnerProvinceController.text =
                  _directorProvinceController.text;
              _ownerOwnerCountryController.text =
                  _directorCountryController.text;
              _ownerOwnerPhoneController.text = _directorPhoneController.text;
              _ownerOwnerEmailController.text = _directorEmailController.text;
              break;
            case 'legalRep':
              _ownerOwnerNameController.text = _legalRepNameController.text;
              _ownerOwnerBirthDateController.text =
                  _legalRepBirthDateController.text;
              _ownerOwnerGenderController.text = _legalRepGenderController.text;
              _ownerOwnerIdController.text = _legalRepIdController.text;
              _ownerOwnerAddressController.text =
                  _legalRepAddressController.text;
              _ownerOwnerHouseNumberController.text =
                  _legalRepHouseNumberController.text;
              _ownerOwnerWardController.text = _legalRepWardController.text;
              _ownerOwnerProvinceController.text =
                  _legalRepProvinceController.text;
              _ownerOwnerCountryController.text =
                  _legalRepCountryController.text;
              _ownerOwnerPhoneController.text = _legalRepPhoneController.text;
              _ownerOwnerEmailController.text = _legalRepEmailController.text;
              break;
          }
          break;
        case 'director':
          switch (sourceRole) {
            case 'founder':
              _directorNameController.text = _founderNameController.text;
              _directorBirthDateController.text =
                  _founderBirthDateController.text;
              _directorGenderController.text = _founderGenderController.text;
              _directorIdController.text = _founderIdController.text;
              _directorAddressController.text = _founderAddressController.text;
              _directorHouseNumberController.text =
                  _founderHouseNumberController.text;
              _directorWardController.text = _founderWardController.text;
              _directorProvinceController.text =
                  _founderProvinceController.text;
              _directorCountryController.text = _founderCountryController.text;
              _directorPhoneController.text = _founderPhoneController.text;
              _directorEmailController.text = _founderEmailController.text;
              break;
            case 'owner':
              _directorNameController.text = _ownerOwnerNameController.text;
              _directorBirthDateController.text =
                  _ownerOwnerBirthDateController.text;
              _directorGenderController.text = _ownerOwnerGenderController.text;
              _directorIdController.text = _ownerOwnerIdController.text;
              _directorAddressController.text =
                  _ownerOwnerAddressController.text;
              _directorHouseNumberController.text =
                  _ownerOwnerHouseNumberController.text;
              _directorWardController.text = _ownerOwnerWardController.text;
              _directorProvinceController.text =
                  _ownerOwnerProvinceController.text;
              _directorCountryController.text =
                  _ownerOwnerCountryController.text;
              _directorPhoneController.text = _ownerOwnerPhoneController.text;
              _directorEmailController.text = _ownerOwnerEmailController.text;
              break;
            case 'legalRep':
              _directorNameController.text = _legalRepNameController.text;
              _directorBirthDateController.text =
                  _legalRepBirthDateController.text;
              _directorGenderController.text = _legalRepGenderController.text;
              _directorIdController.text = _legalRepIdController.text;
              _directorAddressController.text = _legalRepAddressController.text;
              _directorHouseNumberController.text =
                  _legalRepHouseNumberController.text;
              _directorWardController.text = _legalRepWardController.text;
              _directorProvinceController.text =
                  _legalRepProvinceController.text;
              _directorCountryController.text = _legalRepCountryController.text;
              _directorPhoneController.text = _legalRepPhoneController.text;
              _directorEmailController.text = _legalRepEmailController.text;
              break;
          }
          break;
        case 'legalRep':
          switch (sourceRole) {
            case 'founder':
              _legalRepNameController.text = _founderNameController.text;
              _legalRepBirthDateController.text =
                  _founderBirthDateController.text;
              _legalRepGenderController.text = _founderGenderController.text;
              _legalRepIdController.text = _founderIdController.text;
              _legalRepAddressController.text = _founderAddressController.text;
              _legalRepHouseNumberController.text =
                  _founderHouseNumberController.text;
              _legalRepWardController.text = _founderWardController.text;
              _legalRepProvinceController.text =
                  _founderProvinceController.text;
              _legalRepCountryController.text = _founderCountryController.text;
              _legalRepPhoneController.text = _founderPhoneController.text;
              _legalRepEmailController.text = _founderEmailController.text;
              break;
            case 'owner':
              _legalRepNameController.text = _ownerOwnerNameController.text;
              _legalRepBirthDateController.text =
                  _ownerOwnerBirthDateController.text;
              _legalRepGenderController.text = _ownerOwnerGenderController.text;
              _legalRepIdController.text = _ownerOwnerIdController.text;
              _legalRepAddressController.text =
                  _ownerOwnerAddressController.text;
              _legalRepHouseNumberController.text =
                  _ownerOwnerHouseNumberController.text;
              _legalRepWardController.text = _ownerOwnerWardController.text;
              _legalRepProvinceController.text =
                  _ownerOwnerProvinceController.text;
              _legalRepCountryController.text =
                  _ownerOwnerCountryController.text;
              _legalRepPhoneController.text = _ownerOwnerPhoneController.text;
              _legalRepEmailController.text = _ownerOwnerEmailController.text;
              break;
            case 'director':
              _legalRepNameController.text = _directorNameController.text;
              _legalRepBirthDateController.text =
                  _directorBirthDateController.text;
              _legalRepGenderController.text = _directorGenderController.text;
              _legalRepIdController.text = _directorIdController.text;
              _legalRepAddressController.text = _directorAddressController.text;
              _legalRepHouseNumberController.text =
                  _directorHouseNumberController.text;
              _legalRepWardController.text = _directorWardController.text;
              _legalRepProvinceController.text =
                  _directorProvinceController.text;
              _legalRepCountryController.text = _directorCountryController.text;
              _legalRepPhoneController.text = _directorPhoneController.text;
              _legalRepEmailController.text = _directorEmailController.text;
              break;
          }
          break;
      }
    });
  }

  Future<void> fillWordTemplate() async {
    // Load the Word template from assets
    final file01 = await rootBundle.load('assets/01/01.docx');
    final file02 = await rootBundle.load('assets/01/02.docx');
    final file03 = await rootBundle.load('assets/01/03.docx');
    final file04 = await rootBundle.load('assets/01/04.docx');
    final bytes01 = file01.buffer.asUint8List();
    final bytes02 = file02.buffer.asUint8List();
    final bytes03 = file03.buffer.asUint8List();
    final bytes04 = file04.buffer.asUint8List();
    // Create a DocxTemplate instance
    final docx01 = await DocxTemplate.fromBytes(bytes01);
    final docx02 = await DocxTemplate.fromBytes(bytes02);
    final docx03 = await DocxTemplate.fromBytes(bytes03);
    final docx04 = await DocxTemplate.fromBytes(bytes04);

    // Prepare the content to fill
    final content01 = Content()
      // Founder information (người thành lập) - NG_THANH_LAP
      ..add(TextContent("TEN_NG_THANH_LAP", _founderNameController.text))
      ..add(TextContent("DOB_NG_THANH_LAP", _founderBirthDateController.text))
      ..add(TextContent("GENDER_NG_THANH_LAP", _founderGenderController.text))
      ..add(TextContent("ID_NG_THANH_LAP", _founderIdController.text))
      ..add(TextContent("ADDRESS_NG_THANH_LAP", _founderAddressController.text))
      ..add(TextContent(
          "ADDRESS1_NG_THANH_LAP", _founderHouseNumberController.text))
      ..add(TextContent("ADDRESS2_NG_THANH_LAP", _founderWardController.text))
      ..add(
          TextContent("ADDRESS3_NG_THANH_LAP", _founderProvinceController.text))
      ..add(
          TextContent("ADDRESS4_NG_THANH_LAP", _founderCountryController.text))
      ..add(TextContent("PHONE_NG_THANH_LAP", _founderPhoneController.text))
      ..add(TextContent("EMAIL_NG_THANH_LAP", _founderEmailController.text))

      // Company information
      ..add(TextContent("NAME_CTY", _companyNameController.text))
      ..add(TextContent("NAME_CTY_VI", _companyVietnameseNameController.text))
      ..add(TextContent("NAME_CTY_EN", _companyForeignNameController.text))
      ..add(TextContent("NAME_CTY_VT", _companyAbbreviationController.text))
      ..add(TextContent("ADDRESS1_CTY", _companyHouseNumberController.text))
      ..add(TextContent("ADDRESS2_CTY", _companyWardController.text))
      ..add(TextContent("ADDRESS3_CTY", _companyProvinceController.text))
      ..add(TextContent("PHONE_CTY", _companyPhoneController.text))
      ..add(TextContent("FAX_CTY", _companyFaxController.text))
      ..add(TextContent("EMAIL_CTY", _companyEmailController.text))
      ..add(TextContent("WEBSITE_CTY", _companyWebsiteController.text))

      // Capital information
      ..add(
          TextContent("VON_DIEU_LE", _capitalNumberController.text ?? '0 VND'))
      ..add(TextContent(
          "VON_DIEU_LE_CHU", _capitalTextController.text ?? '0 VND'))

      // Detailed capital information
      ..add(TextContent(
          "VON_NGAN_SACH_NN", _stateBudgetCapitalController.text ?? '0 VND'))
      ..add(
          TextContent("VON_TU_NHAN", _privateCapitalController.text ?? '0 VND'))
      ..add(TextContent(
          "VON_NC_NGOAI", _foreignCapitalController.text ?? '0 VND'))
      ..add(TextContent("VON_KHAC", _otherCapitalController.text ?? '0 VND'))
      ..add(TextContent("VON_TONG", _totalCapitalController.text ?? '0 VND'))

      // Contributed assets
      ..add(TextContent("TAI_SAN_VND", _vndAssetsController.text ?? '0 VND'))
      ..add(TextContent(
          "TAI_SAN_NGOAI_TE", _foreignCurrencyAssetsController.text ?? '0 VND'))
      ..add(TextContent("TAI_SAN_VANG", _goldAssetsController.text ?? '0 VND'))
      ..add(
          TextContent("QUYEN_SH_DAT", _landUseRightsController.text ?? '0 VND'))
      ..add(TextContent(
          "QUYEN_SH_TRI_TUE", _intellectualPropertyController.text ?? '0 VND'))
      ..add(TextContent("TAI_SAN_KHAC", _otherAssetsController.text ?? '0 VND'))
      ..add(TextContent(
          "TAI_SAN_TONG", _totalContributedAssetsController.text ?? '0 VND'))

      // Owner information (chủ sở hữu) - CSH
      ..add(TextContent("NAME_CSH", _ownerOwnerNameController.text))
      ..add(TextContent("DOB_CSH", _ownerOwnerBirthDateController.text))
      ..add(TextContent("GENDER_CSH", _ownerOwnerGenderController.text))
      ..add(TextContent("ID_CSH", _ownerOwnerIdController.text))
      ..add(TextContent("ADDRESS_CSH", _ownerOwnerAddressController.text))
      ..add(TextContent("ADDRESS1_CSH", _ownerOwnerHouseNumberController.text))
      ..add(TextContent("ADDRESS2_CSH", _ownerOwnerWardController.text))
      ..add(TextContent("ADDRESS3_CSH", _ownerOwnerProvinceController.text))
      ..add(TextContent("ADDRESS4_CSH", _ownerOwnerCountryController.text))
      ..add(TextContent("PHONE_CSH", _ownerOwnerPhoneController.text))
      ..add(TextContent("EMAIL_CSH", _ownerOwnerEmailController.text))

      // General Director information (tổng giám đốc) - TGD
      ..add(TextContent("NAME_TGD", _directorNameController.text))
      ..add(TextContent("DOB_TGD", _directorBirthDateController.text))
      ..add(TextContent("GENDER_TGD", _directorGenderController.text))
      ..add(TextContent("ID_TGD", _directorIdController.text))
      ..add(TextContent("ADDRESS_TGD", _directorAddressController.text))
      ..add(TextContent("ADDRESS1_TGD", _directorHouseNumberController.text))
      ..add(TextContent("ADDRESS2_TGD", _directorWardController.text))
      ..add(TextContent("ADDRESS3_TGD", _directorProvinceController.text))
      ..add(TextContent("ADDRESS4_TGD", _directorCountryController.text))
      ..add(TextContent("PHONE_TGD", _directorPhoneController.text))
      ..add(TextContent("EMAIL_TGD", _directorEmailController.text))

      // Legal Representative information (người đại diện pháp luật) - NG_DDPL
      ..add(TextContent("NAME_NG_DDPL", _legalRepNameController.text))
      ..add(TextContent("DOB_NG_DDPL", _legalRepBirthDateController.text))
      ..add(TextContent("GENDER_NG_DDPL", _legalRepGenderController.text))
      ..add(TextContent("ID_NG_DDPL", _legalRepIdController.text))
      ..add(TextContent("ADDRESS_NG_DDPL", _legalRepAddressController.text))
      ..add(
          TextContent("ADDRESS1_NG_DDPL", _legalRepHouseNumberController.text))
      ..add(TextContent("ADDRESS2_NG_DDPL", _legalRepWardController.text))
      ..add(TextContent("ADDRESS3_NG_DDPL", _legalRepProvinceController.text))
      ..add(TextContent("ADDRESS4_NG_DDPL", _legalRepCountryController.text))
      ..add(TextContent("PHONE_NG_DDPL", _legalRepPhoneController.text))
      ..add(TextContent("EMAIL_NG_DDPL", _legalRepEmailController.text))
      ..add(TextContent("CHUC_DANH_NG_DDPL", _legalRepPositionController.text))
      // Business Sectors - For table in Word
      ..add(TextContent(
          "BUSINESS_SECTORS_COUNT", _businessSectors.length.toString()))
      ..add(TableContent(
          "table",
          _businessSectors
              .asMap()
              .entries
              .map((entry) => RowContent()
                ..add(TextContent("STT_NGANH", (entry.key + 1).toString()))
                ..add(TextContent("TEN_NGANH", entry.value['name']))
                ..add(TextContent("MA_NGANH", entry.value['code']))
                ..add(TextContent(
                    "NNKD", entry.value['isMain'] ? 'Có' : 'Không')))
              .toList()));
    print("_companyWardController: ${content01.keys.toList()}");
    print("getTags: ${docx01.getTags()}");

    final content02 = Content()
      ..add(TextContent("NAME_CTY", _companyNameController.text))
      ..add(TextContent("NAME_CTY_VI", _companyVietnameseNameController.text))
      ..add(TextContent("NAME_CTY_EN", _companyForeignNameController.text))
      ..add(TextContent("NAME_CTY_VT", _companyAbbreviationController.text))
      ..add(TextContent("ADDRESS_CTY", _companyHouseNumberController.text))
      ..add(TextContent("ADDRESS1_CTY", _companyHouseNumberController.text))
      ..add(TextContent("ADDRESS2_CTY", _companyWardController.text))
      ..add(TextContent("ADDRESS3_CTY", _companyProvinceController.text))
      ..add(TextContent("ADDRESS4_CTY", _companyCountryController.text))
      ..add(TextContent("PHONE_CTY", _companyPhoneController.text))
      ..add(TextContent("FAX_CTY", _companyFaxController.text))
      ..add(TextContent("EMAIL_CTY", _companyEmailController.text))
      ..add(TextContent("WEBSITE_CTY", _companyWebsiteController.text))
      // Legal Representative information (người đại diện pháp luật) - NG_DDPL
      ..add(TextContent("NAME_NG_DDPL", _legalRepNameController.text))
      ..add(TextContent("DOB_NG_DDPL", _legalRepBirthDateController.text))
      ..add(TextContent("GENDER_NG_DDPL", _legalRepGenderController.text))
      ..add(TextContent("ID_NG_DDPL", _legalRepIdController.text))
      ..add(TextContent("ADDRESS_NG_DDPL", _legalRepAddressController.text))
      ..add(
          TextContent("ADDRESS1_NG_DDPL", _legalRepHouseNumberController.text))
      ..add(TextContent("ADDRESS2_NG_DDPL", _legalRepWardController.text))
      ..add(TextContent("ADDRESS3_NG_DDPL", _legalRepProvinceController.text))
      ..add(TextContent("ADDRESS4_NG_DDPL", _legalRepCountryController.text))
      ..add(TextContent("PHONE_NG_DDPL", _legalRepPhoneController.text))
      ..add(TextContent("EMAIL_NG_DDPL", _legalRepEmailController.text))
      ..add(TextContent("CHUC_DANH_NG_DDPL", _legalRepPositionController.text))
      // Owner information (chủ sở hữu) - CSH
      ..add(TextContent("NAME_CSH", _ownerOwnerNameController.text))
      ..add(TextContent("DOB_CSH", _ownerOwnerBirthDateController.text))
      ..add(TextContent("GENDER_CSH", _ownerOwnerGenderController.text))
      ..add(TextContent("ID_CSH", _ownerOwnerIdController.text))
      ..add(TextContent("ADDRESS_CSH", _ownerOwnerAddressController.text))
      ..add(TextContent("ADDRESS1_CSH", _ownerOwnerHouseNumberController.text))
      ..add(TextContent("ADDRESS2_CSH", _ownerOwnerWardController.text))
      ..add(TextContent("ADDRESS3_CSH", _ownerOwnerProvinceController.text))
      ..add(TextContent("ADDRESS4_CSH", _ownerOwnerCountryController.text))
      ..add(TextContent("PHONE_CSH", _ownerOwnerPhoneController.text))
      ..add(TextContent("EMAIL_CSH", _ownerOwnerEmailController.text))
      // Business Sectors - For table in Word
      ..add(TextContent(
          "BUSINESS_SECTORS_COUNT", _businessSectors.length.toString()))
      ..add(TableContent(
          "table",
          _businessSectors
              .asMap()
              .entries
              .map((entry) => RowContent()
                ..add(TextContent("STT_NGANH", (entry.key + 1).toString()))
                ..add(TextContent("TEN_NGANH", entry.value['name']))
                ..add(TextContent("MA_NGANH", entry.value['code']))
                ..add(TextContent(
                    "NNKD", entry.value['isMain'] ? 'Có' : 'Không')))
              .toList()));

    final content03 = Content()
      // Legal Representative information (người đại diện pháp luật) - NG_DDPL
      ..add(TextContent("NAME_NG_DDPL", _legalRepNameController.text))
      ..add(TextContent("DOB_NG_DDPL", _legalRepBirthDateController.text))
      ..add(TextContent("GENDER_NG_DDPL", _legalRepGenderController.text))
      ..add(TextContent("ID_NG_DDPL", _legalRepIdController.text))
      ..add(TextContent("ADDRESS_NG_DDPL", _legalRepAddressController.text))
      ..add(
          TextContent("ADDRESS1_NG_DDPL", _legalRepHouseNumberController.text))
      ..add(TextContent("ADDRESS2_NG_DDPL", _legalRepWardController.text))
      ..add(TextContent("ADDRESS3_NG_DDPL", _legalRepProvinceController.text))
      ..add(TextContent("ADDRESS4_NG_DDPL", _legalRepCountryController.text))
      ..add(TextContent("PHONE_NG_DDPL", _legalRepPhoneController.text))
      ..add(TextContent("EMAIL_NG_DDPL", _legalRepEmailController.text))
      ..add(TextContent("CHUC_DANH_NG_DDPL", _legalRepPositionController.text));

    final content04 = Content()
      ..add(TextContent("NAME_CSH", _ownerOwnerNameController.text))
      ..add(TextContent("DOB_CSH", _ownerOwnerBirthDateController.text))
      ..add(TextContent("GENDER_CSH", _ownerOwnerGenderController.text))
      ..add(TextContent("ID_CSH", _ownerOwnerIdController.text))
      ..add(TextContent("ADDRESS_CSH", _ownerOwnerAddressController.text));

    // Generate the filled document
    final generatedDoc01 = await docx01.generate(content01);
    final generatedDoc02 = await docx02.generate(content02);
    final generatedDoc03 = await docx03.generate(content03);
    final generatedDoc04 = await docx04.generate(content04);
    List<Map<String, dynamic>> filePaths = [
      {
        'name': '01. Giấy đề nghị.docx',
        'bytes': generatedDoc01,
      },
      {
        'name': '02. Điều lệ.docx',
        'bytes': generatedDoc02,
      },
      {
        'name': '03. Ủy quyền.docx',
        'bytes': generatedDoc03,
      },
      {
        'name': '04. DSCSH hưởng lợi.docx',
        'bytes': generatedDoc04,
      },
    ];

    // Save the filled document to the app's documents directory
    final String? directoryPath =
        await getDirectoryPath(confirmButtonText: "Select");
    if (directoryPath == null) {
      return;
    }
    zipFiles(filePaths, _companyNameController.text, directoryPath ?? '');
  }

  void zipFiles(List<Map<String, dynamic>> filesData, String suggestedFileName,
      String directoryPath) async {
    final archive = Archive();
    for (var file in filesData) {
      archive.addFile(
        ArchiveFile(
          file["name"], // tên file trong ZIP
          file["bytes"].length, // kích thước
          file["bytes"], // nội dung bytes
        ),
      );
    }

    // Encode the archive as a BZip2 compressed Tar file.
    final tarData = TarEncoder().encodeBytes(archive);
    final tarBz2 = BZip2Encoder().encodeBytes(tarData);

    // Write the compressed tar file to disk.
    final fp = File('$suggestedFileName.zip');
    fp.writeAsBytesSync(tarBz2);
    // 3️⃣ Lưu ZIP ra thư mục Documents
    final zipPath = "$directoryPath/$suggestedFileName.zip";
    final zipFile = File(zipPath);
    await zipFile.writeAsBytes(tarBz2);

    print("✅ ZIP file created: $zipPath");
    // 4️⃣ Mở thư mục chứa ZIP
    if (Platform.isWindows) {
      await Process.run('explorer', [directoryPath]);
    } else if (Platform.isMacOS) {
      await Process.run('open', [directoryPath]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Công ty một thành viên"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Company information section
            const Text(
              "Thông tin công ty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyNameController,
                      labelText: "Tên công ty"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyVietnameseNameController,
                      labelText: "Tên tiếng Việt"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyForeignNameController,
                      labelText: "Tên tiếng nước ngoài"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyAbbreviationController,
                      labelText: "Tên viết tắt"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyHouseNumberController,
                      labelText: "Số nhà"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyWardController,
                      labelText: "Xã/Phường"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyProvinceController,
                      labelText: "Tỉnh/Thành"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyPhoneController,
                      labelText: "Điện thoại"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyFaxController, labelText: "Fax"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyEmailController, labelText: "Email"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _companyWebsiteController,
                      labelText: "Website"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 20),
            // Founder information section (người thành lập)
            const Text(
              "Thông tin người thành lập",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Áp dụng thông tin của: "),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: _founderApplyFrom,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text("Chọn người"),
                    items: const [
                      DropdownMenuItem(
                          value: null,
                          child: Text("-- Chọn --",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "owner",
                          child: Text("Chủ sở hữu",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "director",
                          child: Text("Tổng giám đốc",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "legalRep",
                          child: Text("Người đại diện pháp luật",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _founderApplyFrom = value;
                      });
                      _applyInformation('founder', value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                const Text(" cho Người thành lập"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderNameController, labelText: "Tên"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderBirthDateController,
                      labelText: "Ngày sinh"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderGenderController,
                      labelText: "Giới tính"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderIdController,
                      labelText: "Số định danh cá nhân"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderAddressController,
                      labelText: "Địa chỉ liên lạc"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderHouseNumberController,
                      labelText: "Số nhà"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderWardController,
                      labelText: "Xã/Phường"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderProvinceController,
                      labelText: "Tỉnh/Thành"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderCountryController,
                      labelText: "Quốc gia"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderPhoneController,
                      labelText: "Điện thoại"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _founderEmailController,
                      labelText: "Thư điện tử"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // Owner information section (chủ sở hữu)
            const Text(
              "Thông tin chủ sở hữu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Áp dụng thông tin của: "),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: _ownerApplyFrom,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text("Chọn người"),
                    items: const [
                      DropdownMenuItem(
                          value: null,
                          child: Text("-- Chọn --",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "founder",
                          child: Text("Người thành lập",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "director",
                          child: Text("Tổng giám đốc",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "legalRep",
                          child: Text("Người đại diện pháp luật",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _ownerApplyFrom = value;
                      });
                      _applyInformation('owner', value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                const Text(" cho Chủ sở hữu"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerNameController, labelText: "Tên"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerBirthDateController,
                      labelText: "Ngày sinh"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerGenderController,
                      labelText: "Giới tính"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerIdController,
                      labelText: "Số định danh cá nhân"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerAddressController,
                      labelText: "Địa chỉ liên lạc"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerHouseNumberController,
                      labelText: "Số nhà"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerWardController,
                      labelText: "Xã/Phường"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerProvinceController,
                      labelText: "Tỉnh/Thành"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerCountryController,
                      labelText: "Quốc gia"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerPhoneController,
                      labelText: "Điện thoại"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _ownerOwnerEmailController,
                      labelText: "Thư điện tử"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // General Director information section (tổng giám đốc)
            const Text(
              "Thông tin tổng giám đốc",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Áp dụng thông tin của: "),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: _directorApplyFrom,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text("Chọn người"),
                    items: const [
                      DropdownMenuItem(
                          value: null,
                          child: Text("-- Chọn --",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "founder",
                          child: Text("Người thành lập",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "owner",
                          child: Text("Chủ sở hữu",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "legalRep",
                          child: Text("Người đại diện pháp luật",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _directorApplyFrom = value;
                      });
                      _applyInformation('director', value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                const Text(" cho Tổng giám đốc"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorNameController, labelText: "Tên"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorBirthDateController,
                      labelText: "Ngày sinh"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorGenderController,
                      labelText: "Giới tính"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorIdController,
                      labelText: "Số định danh cá nhân"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorAddressController,
                      labelText: "Địa chỉ liên lạc"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorHouseNumberController,
                      labelText: "Số nhà"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorWardController,
                      labelText: "Xã/Phường"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorProvinceController,
                      labelText: "Tỉnh/Thành"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorCountryController,
                      labelText: "Quốc gia"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorPhoneController,
                      labelText: "Điện thoại"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _directorEmailController,
                      labelText: "Thư điện tử"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // Legal Representative information section (người đại diện pháp luật)
            const Text(
              "Thông tin người đại diện pháp luật",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Áp dụng thông tin của: "),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: _legalRepApplyFrom,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text("Chọn người"),
                    items: const [
                      DropdownMenuItem(
                          value: null,
                          child: Text("-- Chọn --",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "founder",
                          child: Text("Người thành lập",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "owner",
                          child: Text("Chủ sở hữu",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                      DropdownMenuItem(
                          value: "director",
                          child: Text("Tổng giám đốc",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _legalRepApplyFrom = value;
                      });
                      _applyInformation('legalRep', value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                const Text(" cho Người đại diện pháp luật"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepNameController, labelText: "Tên"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepBirthDateController,
                      labelText: "Ngày sinh"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepGenderController,
                      labelText: "Giới tính"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepIdController,
                      labelText: "Số định danh cá nhân"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepAddressController,
                      labelText: "Địa chỉ liên lạc"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepHouseNumberController,
                      labelText: "Số nhà"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepWardController,
                      labelText: "Xã/Phường"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepProvinceController,
                      labelText: "Tỉnh/Thành"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepCountryController,
                      labelText: "Quốc gia"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepPhoneController,
                      labelText: "Điện thoại"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepEmailController,
                      labelText: "Thư điện tử"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _legalRepPositionController,
                      labelText: "Chức danh"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Capital information section
            const Text(
              "Vốn điều lệ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _capitalNumberController,
                      labelText: "Số vốn"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _capitalTextController,
                      labelText: "Vốn bằng chữ"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // Detailed capital information section
            const Text(
              "Chi tiết vốn điều lệ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _stateBudgetCapitalController,
                      labelText: "Vốn ngân sách nhà nước"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _privateCapitalController,
                      labelText: "Vốn tư nhân"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _foreignCapitalController,
                      labelText: "Vốn nước ngoài"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _otherCapitalController,
                      labelText: "Vốn khác"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _totalCapitalController,
                      labelText: "Tổng số vốn"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // Contributed assets section
            const Text(
              "Tài sản góp vốn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _vndAssetsController,
                      labelText: "Đồng Việt Nam"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _foreignCurrencyAssetsController,
                      labelText: "Ngoại tệ tự chuyển đổi"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _goldAssetsController, labelText: "Vàng"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _landUseRightsController,
                      labelText: "Quyền sử dụng đất"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _intellectualPropertyController,
                      labelText: "Quyền sở hữu trí tuệ"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _otherAssetsController,
                      labelText: "Các tài sản khác"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _totalContributedAssetsController,
                      labelText: "Tổng số tài sản góp vốn"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            // Business sector information section
            const Text(
              "Ngành nghề kinh doanh",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                      controller: _businessNameController,
                      labelText: "Tên ngành nghề"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                      controller: _businessCodeController,
                      labelText: "Mã ngành"),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isMainBusiness,
                        onChanged: _businessSectors.any((sector) => sector['isMain'] == true) && !_isMainBusiness
                            ? null // Disable if another sector is already main
                            : (value) {
                                setState(() {
                                  _isMainBusiness = value ?? false;
                                });
                              },
                      ),
                      Text(
                        "Ngành nghề kinh doanh chính",
                        style: TextStyle(
                          color: _businessSectors.any((sector) => sector['isMain'] == true) && !_isMainBusiness
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addBusinessSector,
                    child: const Text("Thêm ngành nghề"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: SizedBox()),
              ],
            ),

            // Display added business sectors
            if (_businessSectors.isNotEmpty) ...[
              const SizedBox(height: 15),
              const Text(
                "Danh sách ngành nghề đã thêm:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...(_businessSectors.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> sector = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade50,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Tên: ${sector['name']}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Mã: ${sector['code']}"),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          sector['isMain'] ? "Chính" : "Phụ",
                          style: TextStyle(
                            color:
                                sector['isMain'] ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editBusinessSector(index),
                        tooltip: "Chỉnh sửa ngành nghề",
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeBusinessSector(index),
                        tooltip: "Xóa ngành nghề",
                      ),
                    ],
                  ),
                );
              }).toList()),
            ],

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fillWordTemplate,
              child: const Text("Tạo hồ sơ"),
            )
          ],
        ),
      ),
    );
  }
}
