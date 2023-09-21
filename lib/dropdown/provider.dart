import 'package:flutter/foundation.dart';
import 'package:tracking_system/db/db_helper.dart';
import 'package:tracking_system/dropdown/model.dart';

class DropDownProvider extends ChangeNotifier {
  List<String> divisionList = [];
  List<DropDownModel> districtList = [];
  List<DropDownModel> thanaList = [];
  void getAllDivision() {
    DBHelper.getDivision().listen((snapshot) {
      divisionList = List.generate(
          snapshot.docs.length, (index) => snapshot.docs[index].data()['name']);
      notifyListeners();
    });
  }

  void fetchAllDistrict(String type) {
    DBHelper.fetchAllDistrict(type).listen((event) {
      districtList = List.generate(event.docs.length,
          (index) => DropDownModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void fetchAllThana(String type) {
    DBHelper.fetchAllThana(type).listen((event) {
      thanaList = List.generate(event.docs.length,
          (index) => DropDownModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}
