import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_subscription.dart';

class ItemCurrentSubscription extends StatefulWidget {
  final int userId;
   ItemCurrentSubscription({Key? key, required this.userId}) : super(key: key);

  @override
  _ItemCurrentSubscriptionState createState() => _ItemCurrentSubscriptionState();
}

class _ItemCurrentSubscriptionState extends State<ItemCurrentSubscription> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(
        fullScreen: true,
        onModelReady: (model, userId, userType){
          model.getCurrentSubscription(userId: widget.userId);
        },
        builder: (context, model, child){
      return _currentSubscriptionList(model);
    });
  }

  Widget _currentSubscriptionList(CartViewModel provider){
    if(provider.currentSubscriptionModel.success!=null && provider.currentSubscriptionModel.success &&
        provider.currentSubscriptionModel.requestStatus == RequestStatus.loaded){
      return _currentSubscriptionListBuilder(list: provider.currentSubscriptionModel.subscriptionDetails);
    }else if( provider.currentSubscriptionModel.requestStatus == RequestStatus.loading
    ){
      return LoadingProgress();
    }else{
      return SomethingWentWrong(status: getResponse(provider.currentSubscriptionModel.requestStatus));
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
          }) : DataNotFound(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
