import 'package:baitestapi/src/blocs/department/department.dart';
import 'package:baitestapi/src/blocs/staff/staff.dart';
import 'package:baitestapi/src/models/models.dart';
import 'package:baitestapi/src/screens/screens.dart';
import 'package:flutter/material.dart';

class StaffsScreen extends StatefulWidget {
  StaffsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StaffsScreenState createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  final _staffBloc = StaffBloc.getInstance();
  final _departmentBloc = DepartmentBloc.getInstance();

  @override
  void initState() {
    _staffBloc.initFetchStaffs();
    super.initState();
  }

  @override
  void dispose() {
    _staffBloc.dispose();
    _departmentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarStaff(),
      body: StreamBuilder(
        stream: _staffBloc.staffs,
        builder:
            (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildListViewStaffs(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigationToStaff(null);
        },
        tooltip: 'Thêm nhân viên',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildListViewStaffs(List<StaffModel> staffs) {
    return ListView.builder(
      itemCount: staffs.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(staffs[index].getTenNhanVien),
            subtitle: Text(staffs[index].getPhongBan.getTenPhongBan),
            onTap: () {
              _navigationToStaff(staffs[index]);
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

  Widget _buildAppBarStaff() {
    return AppBar(
      title: Text('Danh sách nhân viên'),
      actions: [
        IconButton(
          icon: Icon(Icons.add_business_sharp),
          onPressed: () {
            _navigationToDerpartment();
          },
        ),
      ],
    );
  }

  void _navigationToDerpartment() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ModifyDepartmentScreen();
    }));
  }

  void _navigationToStaff(StaffModel staff) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ModifyStaffScreen(staff: staff);
    }));
  }
}
