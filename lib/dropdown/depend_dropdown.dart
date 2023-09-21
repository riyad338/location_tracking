import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_system/dropdown/provider.dart';

class DropDownPage extends StatefulWidget {
  static const String routeName = '/drop';

  const DropDownPage({Key? key}) : super(key: key);

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  TextEditingController _thanaNamecontroller = TextEditingController();
  TextEditingController _thanaparentController = TextEditingController();
  TextEditingController _districtNamecontroller = TextEditingController();
  TextEditingController _districtparentController = TextEditingController();
  String? _division;
  String? _district;
  String? _thana;
  @override
  late DropDownProvider dropDownProvider;
  @override
  void didChangeDependencies() {
    dropDownProvider = Provider.of<DropDownProvider>(context);
    dropDownProvider.getAllDivision();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              menuMaxHeight: 200.h,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
              hint: Text(
                'Division',
              ),
              value: _division,
              onChanged: (value) {
                setState(() {
                  _division = value;

                  _district = null;
                  _thana = null;
                  dropDownProvider.fetchAllDistrict(_division!);
                });
              },
              items: dropDownProvider.divisionList
                  .map((locat) => DropdownMenuItem(
                        child: Text(
                          locat,
                          // style: TextStyle(
                          //     color: themeProvider.themeModeType ==
                          //             ThemeModeType.Dark
                          //         ? Colors.black54
                          //         : Colors.black54),
                        ),
                        value: locat,
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Search By Location';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              menuMaxHeight: 200.h,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
              hint: Text(
                'District',
              ),
              value: _district,
              onChanged: (value) {
                setState(() {
                  _district = value;

                  _thana = null;
                  dropDownProvider.fetchAllThana(_district!);
                });
              },
              items: dropDownProvider.districtList
                  .map((e) => e.name)
                  .map((locat) => DropdownMenuItem(
                        child: Text(
                          locat!,
                          // style: TextStyle(
                          //     color: themeProvider.themeModeType ==
                          //             ThemeModeType.Dark
                          //         ? Colors.black54
                          //         : Colors.black54),
                        ),
                        value: locat,
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Search By Location';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),

            DropdownButtonFormField<String>(
              menuMaxHeight: 200.h,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
              hint: Text(
                'Thana',
              ),
              value: _thana,
              onChanged: (value) {
                setState(() {
                  _thana = value;
                });
              },
              items: dropDownProvider.thanaList
                  .map((e) => e.name)
                  .map((locat) => DropdownMenuItem(
                        child: Text(
                          locat!,
                          // style: TextStyle(
                          //     color: themeProvider.themeModeType ==
                          //             ThemeModeType.Dark
                          //         ? Colors.black54
                          //         : Colors.black54),
                        ),
                        value: locat,
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Search By Location';
                }
                return null;
              },
            ),
            // DropdownButtonFormField<String>(
            //   menuMaxHeight: 200.h,
            //   decoration: InputDecoration(
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            //     border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.white)),
            //   ),
            //   hint: Text(
            //     'Search By Location',
            //   ),
            //   value: _workLocation,
            //   onChanged: (value) {
            //     setState(() {
            //       _workLocation = value;
            //       _workerProvider.fetchAllWorkerByTypeAndLocation(name!, value!);
            //     });
            //   },
            //   items: _workerProvider.locationList
            //       .map((locat) => DropdownMenuItem(
            //             child: Text(
            //               locat,
            //               // style: TextStyle(
            //               //     color: themeProvider.themeModeType ==
            //               //             ThemeModeType.Dark
            //               //         ? Colors.black54
            //               //         : Colors.black54),
            //             ),
            //             value: locat,
            //           ))
            //       .toList(),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Search By Location';
            //     }
            //     return null;
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 20,
          content: Container(
            height: 100,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addDistrict(context);
                  },
                  child: Text("Add District"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addThana(context);
                  },
                  child: Text("Add Thana"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _addDistrict(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 20,
          title: Text("Add District"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "District Name",
                  ),
                  controller: _districtNamecontroller,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "Division",
                  ),
                  controller: _districtparentController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text("Save"),
                onPressed: () {
                  FirebaseFirestore.instance.collection("District").doc().set({
                    "name": _districtNamecontroller.text,
                    "pId": _districtparentController.text
                  });
                  _districtNamecontroller.clear();
                  _districtparentController.clear();
                }),
          ],
        );
      },
    );
  }

  _addThana(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 20,
          title: Text("Add Thana"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "Thana Name",
                  ),
                  controller: _thanaNamecontroller,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "District",
                  ),
                  controller: _thanaparentController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                FirebaseFirestore.instance.collection("Thana").doc().set({
                  "name": _thanaNamecontroller.text,
                  "pId": _thanaparentController.text
                });
                _thanaparentController.clear();
                _thanaNamecontroller.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
