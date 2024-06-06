import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:intl/intl.dart';

import '../events_page/widgets/events_item_widget.dart';
import 'controller/events_controller.dart';
import 'models/events_item_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventsController controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return GetBuilder<EventsController>(
      id: "event",
      init: EventsController(),
      builder:

          (controller) =>
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseService.eventListCollection
              .snapshots(),
              builder: (context, snapshot){
            if(snapshot.hasData){
             return   snapshot.data!.docs.isEmpty
                  ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.v, left: 20.h, right: 20.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("lbl_events".tr, style: theme.textTheme.headlineMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 116.adaptSize,
                          width: 116.adaptSize,
                          padding: EdgeInsets.all(27.h),
                          decoration: AppDecoration.fillPrimary.copyWith(borderRadius: BorderRadiusStyle.circleBorder58),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgVectorPrimarycontainer61x60,
                            height: 61.v,
                            width: 60.h,
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(height: 20.v),
                        Text("msg_you_have_no_event".tr, style: CustomTextStyles.titleLarge22),
                        SizedBox(height: 19.v),
                        Container(
                          width: 336.h,
                          margin: EdgeInsets.only(left: 45.h, right: 46.h),
                          child: Text(
                            "msg_when_you_book_a".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge!.copyWith(color: appTheme.black900, height: 1.50, fontFamily: 'Montserrat-Medium'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox()
                  ])
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Text("lbl_events".tr, style: theme.textTheme.headlineMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')),
                  ),
                  SizedBox(height: 16.v),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        //EventsItemModel model = controller.eventDataList[index];
                        EventsItemModel model =
                        EventsItemModel(
                            snapshot.data?.docs[index]["eventImages"],
                            snapshot.data?.docs[index]["name"],
                            "location",
                            snapshot.data?.docs[index]["description"],
                            DateFormat('d MMMM, yyyy').format(snapshot.data?.docs[index]["endDate"].toDate()),
                            "₹${snapshot.data?.docs[index]["price"].toInt()}",
                            DateFormat('d MMMM, yyyy').format(snapshot.data?.docs[index]["startDate"].toDate()),
                            snapshot.data?.docs[index]["fromTime"] != null && snapshot.data?.docs[index]["toTime"] != null
                            ? "${DateFormat.jm().format(snapshot.data?.docs[index]["fromTime"].toDate())} - ${DateFormat.jm().format(snapshot.data?.docs[index]["toTime"].toDate())}" : "-",
                            "ticketPrice",
                            "Start date ${DateFormat('d').format(snapshot.data?.docs[index]["timestamp"].toDate())} ${DateFormat('MMMM').format(snapshot.data?.docs[index]["timestamp"].toDate())}",
                            snapshot.data?.docs[index]["preMemoryImages"],
                            snapshot.data?.docs[index]["url"]
                        );
                        return animationfunction(
                            index,
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.v),
                                child: EventsItemWidget(model)));
                      },
                    ),

                  )
                ],
              );
            } else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })

    );
  }
}
