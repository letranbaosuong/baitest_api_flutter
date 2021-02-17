/// [implement]
/// [Mr. Suong]
import 'dart:convert';
import 'package:baitestapi/src/models/models.dart';
import 'package:baitestapi/src/models/staff_model.dart';
import 'package:requests/requests.dart';

class BaiTestApiProvider {
  // final _baseUrl = 'https://192.168.56.1:45456/api/baitest';
  final _hostUrl = 'http://hungle78345.somee.com/api/baitest';
  final _staffs = '/nhanviens';
  final _departments = '/phongbans';
  final _postDepartment = '/AddPhongBan';
  final _putDepartment = '/UpdatePhongBan';
  final _deleteDepartment = '/DeletePhongBan';
  final _postStaff = '/AddNhanVien';
  final _putStaff = '/UpdateNhanVien';
  final _deleteStaff = '/DeleteNhanVien';
  final _getDepartmentById = '/GetPhongBan';
  Map<String, String> _header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
  };

  Future<List<StaffModel>> fetchStaffs() async {
    Response response;
    response = await Requests.get(_hostUrl + _staffs, verify: false);
    if (response.statusCode == 200) {
      Iterable listResponse = json.decode(response.content());
      List<StaffModel> staffs = List<StaffModel>.from(
          listResponse.map((staff) => StaffModel.fromJson(staff)));
      return staffs;
    } else {
      print(response.content());
      throw Exception(
          'Lỗi bai_test_api_provider.dart >>> fetchStaffs(): ${response.statusCode}');
    }
  }

  Future<List<DepartmentModel>> fetchDepartments() async {
    Response response;
    response = await Requests.get(_hostUrl + _departments, verify: false);
    if (response.statusCode == 200) {
      Iterable listResponse = json.decode(response.content());
      List<DepartmentModel> departments = List<DepartmentModel>.from(
          listResponse
              .map((department) => DepartmentModel.fromJson(department)));
      return departments;
    } else {
      throw Exception(
          'Lỗi bai_test_api_provider.dart >>> fetchDepartments(): ${response.statusCode}');
    }
  }

  Future<DepartmentModel> fetchDepartmentById(int departmentId) async {
    Response response;
    response = await Requests.get(
      _hostUrl + _getDepartmentById + '/$departmentId',
      headers: _header,
      verify: false,
    );
    if (response.statusCode == 200) {
      DepartmentModel.fromJson(json.decode(response.content()));
    } else {
      throw Exception(
          'Lỗi bai_test_api_provider.dart >>> fetchDepartmentById(): ${response.statusCode}');
    }

    return DepartmentModel(0, '');
  }

  Future<DepartmentModel> postDepartment(DepartmentModel department) async {
    var myDepartment = department.toJson();
    var departmentBody = json.encode(myDepartment);
    var res = await Requests.post(
      _hostUrl + _postDepartment,
      headers: _header,
      body: departmentBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    if (res.statusCode == 200) {
      return DepartmentModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return DepartmentModel(0, '');
  }

  Future<DepartmentModel> putDepartment(DepartmentModel department) async {
    var myDepartment = department.toJson();
    var departmentBody = json.encode(myDepartment);
    var res = await Requests.put(
      _hostUrl + _putDepartment,
      headers: _header,
      body: departmentBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    if (res.statusCode == 200) {
      return DepartmentModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return DepartmentModel(0, '');
  }

  Future<DepartmentModel> deleteDepartment(int departmentId) async {
    var res = await Requests.delete(
      _hostUrl + _deleteDepartment + '/$departmentId',
      headers: _header,
      verify: false,
    );

    if (res.statusCode == 200) {
      return DepartmentModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return DepartmentModel(0, '');
  }

  Future<StaffModel> postStaff(StaffModel staff) async {
    var myStaff = staff.toJson();
    var staffBody = json.encode(myStaff);
    var res = await Requests.post(
      _hostUrl + _postStaff,
      headers: _header,
      body: staffBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    if (res.statusCode == 200) {
      return StaffModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return StaffModel(0, '', 0, null);
  }

  Future<StaffModel> putStaff(StaffModel staff) async {
    var myStaff = staff.toJson();
    var staffBody = json.encode(myStaff);
    var res = await Requests.put(
      _hostUrl + _putStaff,
      headers: _header,
      body: staffBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    if (res.statusCode == 200) {
      return StaffModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return StaffModel(0, '', 0, null);
  }

  Future<StaffModel> deleteStaff(int staffId) async {
    var objBody = json.encode(staffId);
    var res = await Requests.delete(
      _hostUrl + _deleteStaff,
      headers: _header,
      body: objBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    if (res.statusCode == 200) {
      return StaffModel.fromJson(json.decode(res.content()));
    }

    print(res.statusCode);
    return StaffModel(0, '', 0, null);
  }
}
