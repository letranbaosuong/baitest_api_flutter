class DepartmentModel {
  int _maPhongBan;
  String _tenPhongBan;
  DepartmentModel(this._maPhongBan, this._tenPhongBan);
  int get getMaPhongBan => _maPhongBan;
  String get getTenPhongBan => _tenPhongBan;
  set maPhongBan(int newMaPhongBan) {
    _maPhongBan = newMaPhongBan;
  }

  set tenPhongBan(String newTenPhongBan) {
    _tenPhongBan = newTenPhongBan;
  }

  DepartmentModel.fromJson(dynamic json) {
    this._maPhongBan = json['maPhongBan'];
    this._tenPhongBan = json['tenPhongBan'];
  }
  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();
    json['TenPhongBan'] = _tenPhongBan;
    if (_maPhongBan != null) {
      json['MaPhongBan'] = _maPhongBan;
    }
    return json;
  }
}
