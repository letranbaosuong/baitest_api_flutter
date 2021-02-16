import 'package:baitestapi/src/models/models.dart';

abstract class StaffEvent {}

class FetchStaffs extends StaffEvent {}

class PostStaff extends StaffEvent {
  final StaffModel staff;

  PostStaff(this.staff);
}

class PutStaff extends StaffEvent {
  final StaffModel staff;

  PutStaff(this.staff);
}

class DeleteStaff extends StaffEvent {
  final int staffId;

  DeleteStaff(this.staffId);
}
