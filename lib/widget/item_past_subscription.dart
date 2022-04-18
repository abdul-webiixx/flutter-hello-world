import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/loading.dart';

import 'item_subscription.dart';

class ItemPastSubscription extends StatefulWidget {
  final int userId;
  ItemPastSubscription({Key? key, required this.userId}) : super(key: key);

  @override
  _ItemPastSubscriptionState createState() => _ItemPastSubscriptionState();
}

class _ItemPastSubscriptionState extends State<ItemPastSubscription> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(
        fullScreen: true,
        onModelReady: (model, userId, userType){
          model.getPastSubscription(userId: widget.userId);
        },
        builder: (context, model, child){
      return _currentSubscriptionList(model);
    });
  }

  Widget _currentSubscriptionList(CartViewModel provider){
    if(provider.pastSubscriptionModel.success!=null && provider.pastSubscriptionModel.success &&
        provider.pastSubscriptionModel.requestStatus == RequestStatus.loaded){
      return _currentSubscriptionListBuilder(list: provider.pastSubscriptionModel.subscriptionDetails);
    }else if( provider.pastSubscriptionModel.requestStatus == RequestStatus.loading){
      return LoadingProgress();
    }else{
      return SomethingWentWrong(status: getResponse(provider.pastSubscriptionModel.requestStatus));
    }
  }
  Widget _currentSubscriptionListBuilder({ List<SubscriptionDetails>? list}){
    return Container(
      child: list!=null && list.length>0
          ? ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return MaterialButton(
              onPressed: () {
                // changeScreen(context, SubscriptionsDetailsScreen(subscriptionDetails: list.subscriptionDetails![index],));
              },
                padding: EdgeInsets.all(5),
                child:ItemSubscription(model: list[index]));
          }) :  DataNotFound(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
