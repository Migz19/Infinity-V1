import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

import '../../models/event/event_model.dart';

class HomeProvider extends ChangeNotifier{
  bool eventsLoaded=false;
  bool postsLoaded=false;
  List<EventModel> upcomingEvents=[];
  FirebaseHelper firebaseHelper=FirebaseHelper();

  HomeProvider(){
    getEventsList();
  }

  Future <void>getEventsList() async{
    firebaseHelper.getUpcomingEvents().then((value) => upcomingEvents);

}
}