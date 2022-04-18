import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_review.dart';

import 'oops.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(onModelReady: (model, userId, userType) {
      model.getReviewList();
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(
          title: "Review",
          isLeading: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child: _screenBuilder(model),
        ),
      );
    });
  }

  Widget _screenBuilder(AppViewModel provider) {
    if (provider.reviewModel.success != null &&
        provider.reviewModel.success &&
        provider.reviewModel.requestStatus == RequestStatus.loaded) {
      return _listReviewProvider(model: provider.reviewModel.reviewData);
    } else if (provider.reviewModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.reviewModel.requestStatus),
        message: provider.reviewModel.requestStatus == RequestStatus.failure
            ? provider.failure.message
            : null,
      );
    }
  }

  Widget _listReviewProvider({ReviewData? model}) {
    if (model != null &&
        model.reviewDetails != null &&
        model.reviewDetails!.length > 0) {
      return _listReviewBuilder(list: model.reviewDetails!);
    } else {
      return DataNotFound();
    }
  }

  Widget _listReviewBuilder({required List<ReviewDetails> list}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: GestureDetector(
                onTap: () {},
                child: ItemReview(
                  isHome: false,
                  model: list[index],
                )),
          );
        });
  }
}
