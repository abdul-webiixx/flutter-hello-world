import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/utils/auto_complete_field.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/search.dart';
import 'package:Zenith/screen/service_package.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_search.dart';
import 'oops.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedLetter;
  String? searchItem = "Course";
  late TextEditingController _searchController;
  final searchData = <String>[
    "Belly",
    "Belly Dance Course",
    "Belly Live Class",
    "Hip hop",
    "Hip Dance Course",
    "Hip Hop Live Class",
    "Jazz",
    "Jazz Dance Course",
    "Jazz Live Class",
  ];
  final formKey = GlobalKey<FormState>();
  bool _animate = false;

  static bool _isStart = true;
  bool autoValidate = false;

  @override
  void initState() {
    super.initState();
    _searchController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(onModelReady: (model, userId, userType) {
      model.getSearch(keyword: searchItem!);
      _isStart
          ? Future.delayed(Duration(milliseconds: 1 * 100), () {
              setState(() {
                _animate = true;
                _isStart = false;
              });
            })
          : _animate = true;
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: BaseAppBar(isLeading: true),
          body: Container(
              child: Form(
            key: formKey,
            autovalidateMode: autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.only(
                  left: 15,
                ),
                decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      alignment: Alignment.center,
                      child: SimpleAutocompleteFormField<String>(
                        itemBuilder: (context, model) => Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: regular,
                                        color: Theme.of(context).hintColor)),
                              ]),
                        ),
                        controller: _searchController,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            fillColor: Theme.of(context).highlightColor,
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            hintText: "Search",
                            hintStyle: styleProvider(
                                size: 12,
                                color: Theme.of(context).hintColor,
                                fontWeight: regular)),
                        onSearch: (search) async => searchData
                            .where((searchData) => searchData
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList(),
                        style: styleProvider(size: 12, fontWeight: regular),
                        itemFromString: (string) {
                          final matches = searchData.where((person) =>
                              person.toLowerCase() == string.toLowerCase());
                          return matches.isEmpty ? null : matches.first;
                        },
                        onChanged: (value) =>
                            setState(() => searchItem = value),
                        onSaved: (value) => setState(() => searchItem = value),
                        validator: (person) =>
                            person == null ? 'Invalid person.' : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.getSearch(keyword: searchItem!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _notificationBuilder(model)
            ]),
          )));
    });
  }

  Widget _notificationBuilder(AppViewModel provider) {
    if (provider.searchModel.success != null &&
        provider.searchModel.success &&
        provider.searchModel.requestStatus == RequestStatus.loaded) {
      return _animListProvider(list: provider.searchModel.searchData);
    } else if (provider.searchModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.searchModel.requestStatus),
        message: provider.searchModel.requestStatus == RequestStatus.failure
            ? provider.failure.message
            : null,
      );
    }
  }

  Widget _animListProvider({required List<SearchData>? list}) {
    if (list != null && list.length > 0) {
      return Container(
          height: MediaQuery.of(context).size.height - 150,
          child: LiveList.options(
              scrollDirection: Axis.vertical,
              itemBuilder: (
                BuildContext context,
                int index,
                Animation<double> animation,
              ) =>
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    // And slide transition
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, -0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      // Paste you Widget
                      child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          onPressed: () {
                            moveToScreen(
                                list[index].productType != null
                                    ? list[index].productType!
                                    : 1,
                                list[index].name!);
                          },
                          child: ItemSearch(
                            model: list[index],
                          )),
                    ),
                  ),
              itemCount: list.length,
              options: animOption));
    } else {
      return DataNotFound();
    }
  }

  Widget searchProvider() {
    return SafeArea(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: new TextFormField(
          decoration: InputDecoration(
              hintText: "search here",
              hintStyle: styleProvider(
                  fontWeight: regular, size: 12, color: Colors.black)),
          keyboardType: TextInputType.emailAddress,
          style: new TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black),
        ),
      ),
    );
  }

  Widget listSearch({required List<SearchData> list}) {
    return Container(
      height: 400,
      child: ListView(
        children: List.generate(
            list.length,
            (index) => AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: _animate ? 1 : 0,
                  curve: Curves.easeInOutQuart,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 1000),
                    padding: _animate
                        ? const EdgeInsets.all(4.0)
                        : const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        onPressed: () {
                          moveToScreen(
                              list[index].productType != null
                                  ? list[index].productType!
                                  : 1,
                              list[index].name!);
                        },
                        child: ItemSearch(
                          model: list[index],
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  void moveToScreen(int id, String title) {
    switch (id) {
      case 1:
        changeScreen(
            context,
            ServicePackage(
                serviceTypeId: id, classId: 1, serviceId: 1, form: title));
        break;
      case 2:
        changeScreen(
            context,
            ServicePackage(
                serviceTypeId: id, classId: 1, serviceId: 1, form: title));
        break;
      case 3:
        changeScreen(
            context,
            ServicePackage(
                serviceTypeId: id, classId: 1, serviceId: 1, form: title));
        break;
      case 4:
        break;
    }
  }
}
