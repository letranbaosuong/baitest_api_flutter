import 'package:baitestapi/src/models/models.dart';

/// [interface]
/// [Mr. Suong]
import 'package:baitestapi/src/resources/resources.dart';

class BaiTestApiRepository {
  final _baiTestApiProvider = BaiTestApiProvider();
  Future<List<StaffModel>> fetchStaffs() => _baiTestApiProvider.fetchStaffs();
  Future<List<DepartmentModel>> fetchDepartments() =>
      _baiTestApiProvider.fetchDepartments();
  Future<DepartmentModel> fetchDepartmentById(int departmentId) =>
      _baiTestApiProvider.fetchDepartmentById(departmentId);
  Future<DepartmentModel> postDepartment(DepartmentModel department) =>
      _baiTestApiProvider.postDepartment(department);
  Future<DepartmentModel> putDepartment(DepartmentModel department) =>
      _baiTestApiProvider.putDepartment(department);
  Future<DepartmentModel> deleteDepartment(int departmentId) =>
      _baiTestApiProvider.deleteDepartment(departmentId);
  Future<StaffModel> postStaff(StaffModel staff) =>
      _baiTestApiProvider.postStaff(staff);
  Future<StaffModel> putStaff(StaffModel staff) =>
      _baiTestApiProvider.putStaff(staff);
  Future<StaffModel> deleteStaff(int staffId) =>
      _baiTestApiProvider.deleteStaff(staffId);
}
