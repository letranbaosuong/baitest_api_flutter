import 'package:baitestapi/src/blocs/blocs.dart';
import 'package:baitestapi/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModifyDepartmentScreen extends StatefulWidget {
  @override
  _ModifyDepartmentScreenState createState() => _ModifyDepartmentScreenState();
}

class _ModifyDepartmentScreenState extends State<ModifyDepartmentScreen> {
  final _departmentBloc = DepartmentBloc.getInstance();
  var _textStyle = TextStyle();
  var _txtNameDepartment = TextEditingController();

  @override
  void initState() {
    _departmentBloc.initFetchDepartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: _buildAppBarDepartment(),
      body: StreamBuilder(
          stream: _departmentBloc.departments,
          builder: (BuildContext context,
              AsyncSnapshot<List<DepartmentModel>> snapshot) {
            if (snapshot.hasData) {
              return _buildListViewBody(snapshot.data, context);
            } else {
              return Center(child: CircularProgressIndicator());
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
            controller: _txtNameDepartment
              ..text = _departmentBloc.departmentSelected.getTenPhongBan,
            style: _textStyle,
            onChanged: (val) => _updateNameDepartment(val),
            decoration: InputDecoration(
              labelText: 'Tên phòng ban',
              labelStyle: _textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Thêm'),
                onPressed: () {
                  _departmentBloc
                      .postDepartment(_departmentBloc.departmentSelected);
                },
              ),
              RaisedButton(
                child: Text(
                    'Sửa (${_departmentBloc.departmentSelected.getMaPhongBan})'),
                onPressed: () {
                  _departmentBloc
                      .putDepartment(_departmentBloc.departmentSelected);
                },
              ),
              RaisedButton(
                child: Text(
                    'Xóa (${_departmentBloc.departmentSelected.getMaPhongBan})'),
                onPressed: () {
                  _showAlertDialogDeleteDepartment(
                      context, _departmentBloc.departmentSelected);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBarDepartment() {
    return AppBar(
      title: Text('Quản lý phòng ban'),
    );
  }

  void _updateNameDepartment(String val) {
    _departmentBloc.departmentSelected.tenPhongBan = val;
  }

  void _showAlertDialogDeleteDepartment(
      BuildContext context, DepartmentModel department) {
    showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text('Xác nhận xóa Phòng ban!'),
          content: Text(
              'Bạn có chắc chắn muốn xóa phòng ban ${department.getTenPhongBan} này không?'),
          actions: <Widget>[
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Không')),
            CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.red),
                isDefaultAction: true,
                onPressed: () async {
                  _departmentBloc.deleteDepartment(department.getMaPhongBan);
                  Navigator.pop(context);
                },
                child: Text('Có')),
          ],
        ));
  }
}
