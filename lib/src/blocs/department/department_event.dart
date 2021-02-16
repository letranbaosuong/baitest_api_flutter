import 'package:baitestapi/src/models/models.dart';

abstract class DepartmentEvent {}

class FetchDepartments extends DepartmentEvent {}

class FetchDepartmentById extends DepartmentEvent {
  final int departmentId;

  FetchDepartmentById(this.departmentId);
}

class PostDepartment extends DepartmentEvent {
  final DepartmentModel department;

  PostDepartment(this.department);
}

class PutDepartment extends DepartmentEvent {
  final DepartmentModel department;

  PutDepartment(this.department);
}

class DeleteDepartment extends DepartmentEvent {
  final int departmentId;

  DeleteDepartment(this.departmentId);
}
