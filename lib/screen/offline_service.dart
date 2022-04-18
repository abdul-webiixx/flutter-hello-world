import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/state.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/service.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_state_dropdown_menu.dart';

class OfflineServiceScreen extends StatefulWidget {
  @override
  _OfflineServiceScreenState createState() => _OfflineServiceScreenState();
}

class _OfflineServiceScreenState extends State<OfflineServiceScreen> {
  bool checked = false;
  StateListItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(onModelReady: (model, userId, userType) {
      model.getOfflineCenter();
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: "Offline Classes",
          isLeading: true,
        ),
        body: _centerListProvider(model),
      );
    });
  }

  Widget _centerListProvider(AppViewModel provider) {
    if (provider.stateModel.success != null &&
        provider.stateModel.requestStatus == RequestStatus.loaded) {
      if (provider.stateModel.states != null &&
          provider.stateModel.states!.length > 0) {
        selectedItem = provider.stateModel.states![0];
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Kindly select your dance centre",
            style: styleProvider(
              size: 14,
              fontWeight: extraLight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: SizeConfig.screenWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: highlightColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StateListDropdown(
                  defaultValue: selectedItem,
                  stateList: provider.stateModel.states != null
                      ? provider.stateModel.states
                      : [],
                  hint: "Offline Center",
                  onChanged: (StateListItem model) {
                    setState(() {
                      selectedItem = model;
                    });
                  },
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: white,
                  size: 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BaseView<ClassViewModel>(
              fullScreen: true,
              builder: (context, model, child) {
                return CustomButton(
                    onPressed: () {
                      if (selectedItem != null) {
                        model.setCenterId(centerId: selectedItem!.id!);
                        changeScreen(
                            context,
                            ServiceScreen(
                              isOffline: true,
                            ));
                      } else {
                        showToast(context, msg: no_center_found);
                      }
                    },
                    title: "Next");
              })
        ],
      );
    } else if (provider.stateModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.stateModel.requestStatus));
    }
  }
}
