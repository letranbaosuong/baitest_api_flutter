import 'package:baitestapi/src/blocs/blocs.dart';
import 'package:baitestapi/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModifyStaffScreen extends StatefulWidget {
  final StaffModel staff;

  const ModifyStaffScreen({Key key, this.staff}) : super(key: key);
  @override
  _ModifyStaffScreenState createState() => _ModifyStaffScreenState(this.staff);
}

class _ModifyStaffScreenState extends State<ModifyStaffScreen> {
  StaffModel staff;
  _ModifyStaffScreenState(this.staff);
  final _departmentBloc = DepartmentBloc.getInstance();
  final _staffBloc = StaffBloc.getInstance();
  // var _txtNameStaff = TextEditingController();
  var _textStyle = TextStyle();

  @override
  void initState() {
    _departmentBloc.initFetchDepartments();
    if (staff != null) {
      print(
          '${staff.getPhongBan.getMaPhongBan} - ${staff.getPhongBan.getTenPhongBan}');
      _departmentBloc.fetchDepartmentById(staff.getPhongBan.getMaPhongBan);
    } else {
      staff = StaffModel(0, '', 0, DepartmentModel(0, ''));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý nhân viên'),
      ),
      body: StreamBuilder(
          stream: _departmentBloc.departments,
          builder: (BuildContext context,
              AsyncSnapshot<List<DepartmentModel>> snapshot) {
            if (snapshot.hasData) {
              return _buildListViewBody(snapshot.data, context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _buildListViewBody(
      List<DepartmentModel> departments, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.035),
      child: ListView(
        children: [
          DropdownButton<DepartmentModel>(
            items: departments
                .map<DropdownMenuItem<DepartmentModel>>(
                    (DepartmentModel e) => DropdownMenuItem<DepartmentModel>(
                          value: e,
                          child: Text(e.getTenPhongBan),
                        ))
                .toList(),
            style: _textStyle,
            value: _departmentBloc.departmentSelected,
            onChanged: (value) {
              setState(() {
                _departmentBloc.departmentSelected = value;
              });
            },
          ),
          TextFormField(
            onChanged: (value) => _updateNameStaff(value),
            initialValue: staff != null ? staff.getTenNhanVien : '',
            // controller: _txtNameStaff
            //   ..text = staff != null ? staff.getTenNhanVien : '',
            style: _textStyle,
            decoration: InputDecoration(
              labelText: 'Tên nhân viên',
              labelStyle: _textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              staff.getMaNhanVien == 0
                  ? RaisedButton(
                      child: Text('Thêm'),
                      onPressed: () {
                        _setDepartmentForStaff();
                        _staffBloc.postStaff(staff);
                        Navigator.of(context).pop();
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text('Sửa'),
                          onPressed: () {
                            _setDepartmentForStaff();
                            _staffBloc.putStaff(staff);
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.065),
                        RaisedButton(
                          child: Text('Xóa'),
                          onPressed: () {
                            _showAlertDialogDeleteStaff(context, staff);
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void _setDepartmentForStaff() {
    setState(() {
      print(
          '${_departmentBloc.departmentSelected.getMaPhongBan} - ${_departmentBloc.departmentSelected.getTenPhongBan}');
      staff.maPhongBan = _departmentBloc.departmentSelected.getMaPhongBan;
      staff.phongBan = _departmentBloc.departmentSelected;
    });
  }

  void _updateNameStaff(String value) {
    setState(() {
      staff.tenNhanVien = value.trim();
    });
  }

  void _showAlertDialogDeleteStaff(BuildContext context, StaffModel staff) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text('Xác nhận xóa Nhân viên!'),
        content: Text(
            'Bạn có chắc chắn muốn xóa nhân viên ${staff.getTenNhanVien} này không?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Không'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Có'),
            textStyle: TextStyle(color: Colors.red),
            isDefaultAction: true,
            onPressed: () {
              _staffBloc.deleteStaff(staff.getMaNhanVien);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
