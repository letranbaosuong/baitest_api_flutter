import 'package:baitestapi/src/models/department_model.dart';

class StaffModel {
  int _maNhanVien;
  String _tenNhanVien;
  int _maPhongBan;
  DepartmentModel _phongBan;
  StaffModel(
      this._maNhanVien, this._tenNhanVien, this._maPhongBan, this._phongBan);
  int get getMaNhanVien => _maNhanVien;
  String get getTenNhanVien => _tenNhanVien;
  int get getMaPhongBan => _maPhongBan;
  DepartmentModel get getPhongBan => _phongBan;
  set maNhanVien(int newMaNhanVien) {
    _maNhanVien = newMaNhanVien;
  }

  set tenNhanVien(String newTenNhanVien) {
    _tenNhanVien = newTenNhanVien;
  }

  set maPhongBan(int newMaPhongBan) {
    _maPhongBan = newMaPhongBan;
  }

  set phongBan(DepartmentModel newPhongBan) {
    _phongBan = newPhongBan;
  }

  StaffModel.fromJson(dynamic json) {
    _maNhanVien = json['maNhanVien'];
    _tenNhanVien = json['tenNhanVien'];
    _maPhongBan = json['maPhongBan'];
    _phongBan = DepartmentModel.fromJson(json['phongBan']);
  }
  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();
    json['tenNhanVien'] = _tenNhanVien;
    json['maPhongBan'] = _maPhongBan;
    if (_phongBan != null) {
      json['phongBan'] = _phongBan.toJson();
    }
    if (_maNhanVien != null) {
      json['maNhanVien'] = _maNhanVien;
    }
    return json;
  }
}
