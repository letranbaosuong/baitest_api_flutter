import 'dart:async';

import 'package:baitestapi/src/blocs/staff/staff.dart';
import 'package:baitestapi/src/models/models.dart';
import 'package:baitestapi/src/resources/resources.dart';
import 'package:rxdart/rxdart.dart';

class StaffBloc {
  StaffBloc._internal();
  static final StaffBloc _singleton = StaffBloc._internal();
  static StaffBloc getInstance() => _singleton;
  final _baiTestApiRepository = BaiTestApiRepository();
  final _staffsFetcher = PublishSubject<List<StaffModel>>();
  final _eventStaffController = StreamController<StaffEvent>.broadcast();
  Stream<List<StaffModel>> get staffs => _staffsFetcher.stream;

  void initialize() {
    _listenStaff();
  }

  void _listenStaff() {
    _eventStaffController.stream.listen((StaffEvent event) async {
      if (event is FetchStaffs) {
      } else if (event is PostStaff) {
        event.staff.maNhanVien = null;
        event.staff.phongBan = null;
        var resStaff = await _baiTestApiRepository.postStaff(event.staff);
        print(
            'post staff - ${resStaff.getMaNhanVien} - ${resStaff.getTenNhanVien}');
      } else if (event is PutStaff) {
        var resStaff = await _baiTestApiRepository.putStaff(event.staff);
        print(
            'put staff - ${resStaff.getMaNhanVien} - ${resStaff.getTenNhanVien}');
      } else if (event is DeleteStaff) {
        var resStaff = await _baiTestApiRepository.deleteStaff(event.staffId);
        print(
            'delete staff - ${resStaff.getMaNhanVien} - ${resStaff.getTenNhanVien}');
      }

      List<StaffModel> staffs = await _baiTestApiRepository.fetchStaffs();
      _staffsFetcher.sink.add(staffs);
      print('bloc fetch staffs');
    });
  }

  void initFetchStaffs() {
    _eventStaffController.sink.add(FetchStaffs());
  }

  void postStaff(StaffModel staff) {
    _eventStaffController.sink.add(PostStaff(staff));
  }

  void putStaff(StaffModel staff) {
    _eventStaffController.sink.add(PutStaff(staff));
  }

  void deleteStaff(int staffId) {
    _eventStaffController.sink.add(DeleteStaff(staffId));
  }

  void dispose() {
    _staffsFetcher.close();
    _eventStaffController.close();
  }
}
