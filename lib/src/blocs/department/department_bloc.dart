import 'dart:async';

import 'package:baitestapi/src/blocs/blocs.dart';
import 'package:baitestapi/src/blocs/department/department.dart';
import 'package:baitestapi/src/models/models.dart';
import 'package:baitestapi/src/resources/resources.dart';
import 'package:rxdart/rxdart.dart';

class DepartmentBloc {
  DepartmentBloc._internal();
  static final _singleton = DepartmentBloc._internal();
  static DepartmentBloc getInstance() => _singleton;
  final _staffBloc = StaffBloc.getInstance();
  final _baiTestApiRepository = BaiTestApiRepository();
  final _departmentsFetcher = PublishSubject<List<DepartmentModel>>();
  final _eventDepartmentController =
      StreamController<DepartmentEvent>.broadcast();
  Stream<List<DepartmentModel>> get departments => _departmentsFetcher.stream;
  DepartmentModel departmentSelected = DepartmentModel(0, '');
  DepartmentModel resDepartment;

  void initialize() {
    _listenDepartment();
  }

  void _listenDepartment() {
    _eventDepartmentController.stream.listen((DepartmentEvent event) async {
      if (event is FetchDepartments) {
        List<DepartmentModel> listD =
            await _baiTestApiRepository.fetchDepartments();
        _departmentsFetcher.sink.add(listD);
        departmentSelected = listD[0];
        print('fetch departments');
      } else if (event is PostDepartment) {
        event.department.maPhongBan = null;
        resDepartment =
            await _baiTestApiRepository.postDepartment(event.department);
        List<DepartmentModel> listD =
            await _baiTestApiRepository.fetchDepartments();
        _departmentsFetcher.sink.add(listD);
        departmentSelected = listD[listD.length - 1];
        print('post - fetch departments >>> ${resDepartment.getMaPhongBan}');
      } else if (event is PutDepartment) {
        resDepartment =
            await _baiTestApiRepository.putDepartment(event.department);
        List<DepartmentModel> listD =
            await _baiTestApiRepository.fetchDepartments();
        int indexPut = listD.indexWhere(
            (dep) => dep.getMaPhongBan == resDepartment.getMaPhongBan);
        _departmentsFetcher.sink.add(listD);
        departmentSelected = listD[indexPut];
        print('put - fetch department >>> ${resDepartment.getMaPhongBan}');
        _staffBloc.initFetchStaffs();
        print('fetch update staffs');
      } else if (event is DeleteDepartment) {
        resDepartment =
            await _baiTestApiRepository.deleteDepartment(event.departmentId);
        List<DepartmentModel> listD =
            await _baiTestApiRepository.fetchDepartments();
        _departmentsFetcher.sink.add(listD);
        departmentSelected = listD[0];
        print('delete - fetch department >>> ${resDepartment.getMaPhongBan}');
        _staffBloc.initFetchStaffs();
        print('fetch update staffs');
      } else if (event is FetchDepartmentById) {
        List<DepartmentModel> listD =
            await _baiTestApiRepository.fetchDepartments();
        int indexFetch =
            listD.indexWhere((dep) => dep.getMaPhongBan == event.departmentId);
        _departmentsFetcher.sink.add(listD);
        departmentSelected = listD[indexFetch];
        print(
            'fetch - fetch department by id >>> ${departmentSelected.getMaPhongBan}');
      }
    });
  }

  void initFetchDepartments() {
    _eventDepartmentController.sink.add(FetchDepartments());
  }

  void fetchDepartmentById(int departmentId) {
    _eventDepartmentController.sink.add(FetchDepartmentById(departmentId));
  }

  void postDepartment(DepartmentModel department) {
    _eventDepartmentController.sink.add(PostDepartment(department));
  }

  void putDepartment(DepartmentModel department) {
    _eventDepartmentController.sink.add(PutDepartment(department));
  }

  void deleteDepartment(int departmentId) {
    _eventDepartmentController.sink.add(DeleteDepartment(departmentId));
  }

  void dispose() {
    _departmentsFetcher.close();
    _eventDepartmentController.close();
  }
}
