import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/all_instructor_model.dart';
import 'package:Zenith/screen/instructor_profile.dart';
import 'package:Zenith/services/app.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllInstructorScreen extends StatefulWidget {
  const AllInstructorScreen({Key? key}) : super(key: key);

  @override
  _AllInstructorScreenState createState() => _AllInstructorScreenState();
}

class _AllInstructorScreenState extends State<AllInstructorScreen> {
  late FirebaseService _firebaseService;
  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) {
          model.setUserId(userId);
          _firebaseService = new FirebaseService();
          model.getHome(userId: userId!).then((value) => null).onError(
              (error, stackTrace) => _firebaseService.firebaseJsonError(
                  apiCall: "getHome",
                  message: error.toString(),
                  stackTrace: stackTrace,
                  userId: userId));
          model.setUserId(userId);
        },
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: BaseAppBar(title: "All Instructor", isLeading: true),
              body: FutureBuilder<AllInstructorsModel>(
                future: AppService.getAllInstructor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: LoadingProgress(),
                    );
                  }
                  return GridView.builder(
                      itemCount: snapshot.data.data!.subdata!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: (300 / 328),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            AppService.getInstructorProfile(
                                    instructor_id:
                                        snapshot.data.data!.subdata![index].id)
                                .then((value) {
                              changeScreen(
                                  context,
                                  InstructorProfileScreen(
                                      model:
                                          value));
                            });
                          },
                          child: GridItemsView(
                            subData: snapshot.data.data!.subdata![index],
                            storage_path: snapshot.data.storagePath!,
                          ),
                        );
                      });
                },
              ),
            ),
          );
        });
  }
}

class GridItemsView extends StatelessWidget {
  final SubData? subData;
  final String? storage_path;
  const GridItemsView({Key? key, this.subData, this.storage_path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 5),
      width: 130,
      height: 200,
      color: black,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 130,
                  // alignment: Alignment.center
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).highlightColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: subData!.avatar != null
                        ? '$storage_path${subData!.avatar!}'
                        : "",
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Image.asset(
                      moke_image1,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          new Positioned(
            right: 20,
            bottom: 5,
            left: 20, //
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [amber_600!, amber_400!]),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                subData!.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styleProvider(
                    fontWeight: semiBold,
                    size: 10,
                    color: Theme.of(context).backgroundColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
