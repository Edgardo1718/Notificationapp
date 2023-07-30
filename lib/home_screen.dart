import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notimovil/notification_services.dart';
import "package:http/http.dart" as http;
class HomeScreen extends StatefulWidget{
  const HomeScreen({Key?key}): super(key: key);
  @override
  State<HomeScreen>createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  final title=TextEditingController();
  final body=TextEditingController();
  NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print("Device token");
      print(value);
    });
    
  }
 
  @override
Widget build(BuildContext context) {

  return Scaffold(
    body: Container(
      color: Color(0xFF69A695),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            notificationServices.getDeviceToken().then((value) async {
              const movil = "dqogJg-LRrmBXoQ8cd9Ty8:APA91bEky74qgz6z7iAlDbYOaDBEFNf2pC0-hxzZ6lHbalI8EIo21MpN8vK8wLf-o2n6BxuS_YCmx8uTEcmwsWN3185-KS8RP8ExujacVKkfdbImylLHcdvzaTfemsuwuicWt_g0iIfF";
              const wear = "e5JXJcMwS4GW1XWyDnwiNj:APA91bFU9OWyzvxSKPvzMJRG0DkDCJXImgwxcXvzO_KxGqPSsLbhWHZB5lXPVf_ki9f_nU4QzY8VEHxYVbqedDX-S8gt0U0ZF5i51AtOF3LeBq33CkuxjinrcdWokS6FIZiEHwGboCRG";
              var data = {
                "to": movil,
                "priority": "high",
                "notification": {
                  "title": "Hola",
                  "body": "Soy una notificacion",
                },
                "data": {
                  "type": "msj",
                  "id": "123456"
                }
              };
              await http.post(
                Uri.parse("https://fcm.googleapis.com/fcm/send"),
                body: jsonEncode(data),
                headers: {
                  "Content-Type": "application/json; charset=UTF-8",
                  "Authorization": "key=AAAAOwvxDRM:APA91bGRPH8kIuZ54e-iMLzdTvrZRYldTUzPWl0YYkJLrz7M8J6Uiv2uMQ5fuTVaJzQ7HmRj8T6XAJr6aa1v0_lVDIicOysZPUSctOPwscG2tCvjxuVUXMyFqjaPhThN0U2cQQHefEsQ"
                },
              );
            });
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0x236052)),
          ),
          child: const Text('Enviar'),
        ),
      ),
    ),
  );
}
}