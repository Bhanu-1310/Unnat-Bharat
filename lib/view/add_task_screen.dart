// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/controller/firebase_methods.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/widgets/login_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../globals/colors.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController captionContoller = TextEditingController();
  TextEditingController dateAndTimeController = TextEditingController();

  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add a task".text.make(),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintText: "Write a task..."),
                controller: captionContoller,
              ),
            ),
            20.heightBox,
            SizedBox(
              width: double.infinity,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintText: "Enter Date and Time..."),
                controller: dateAndTimeController,
              ),
            ),
            const Spacer(),
            isUploading
                ? const LinearProgressIndicator()
                : uploadButton("Schedule Now").onTap(() async {
                    isUploading = true;
                    String res = await FirebaseMethods().uploadPost(
                        captionContoller.text,
                        FirebaseAuth.instance.currentUser!.uid,
                        currentUsername,
                        dateAndTimeController.text);
                    if (res == "success") {
                      isUploading = false;
                      showSnackBar("Schedule Successful", context);
                      Future.delayed(const Duration(milliseconds: 1250), () {
                        Navigator.pop(context);
                      });
                    }
                    isUploading = false;
                  }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget uploadButton(
  String text,
) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), gradient: myGradient),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}


// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

// class ScheduleNotificationScreen extends StatefulWidget {
//   @override
//   _ScheduleNotificationScreenState createState() =>
//       _ScheduleNotificationScreenState();
// }

// class _ScheduleNotificationScreenState
//     extends State<ScheduleNotificationScreen> {
//   final newYorkTimeZone = 'America/New_York';
//   tz.TZDateTime convertToTZDateTime(DateTime dateTime, String timeZoneName) {
//     final timeZone = tz.getLocation(timeZoneName);
//     final tzDateTime = tz.TZDateTime.from(dateTime, timeZone);

//     return tzDateTime;
//   }

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   AndroidInitializationSettings? androidInitializationSettings;
//   InitializationSettings? initializationSettings;

//   DateTime? selectedDateTime;
//   String notificationMessage = 'This is a scheduled notification!';

//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//   }

//   Future<void> initializeNotifications() async {
//     androidInitializationSettings =
//         const AndroidInitializationSettings('app_icon');
//     initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings!);
//   }

//   Future<void> scheduleNotification() async {
//     if (selectedDateTime != null) {
//       final scheduledDate =
//           selectedDateTime!.subtract(const Duration(seconds: 5));

//       final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         // 'channel_description',
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       final platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//       );

//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Scheduled Notification',
//         notificationMessage,
//         convertToTZDateTime(scheduledDate, newYorkTimeZone),
//         platformChannelSpecifics,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true,
//       );

//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Notification Scheduled'),
//           content:
//               const Text('The notification has been scheduled successfully.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Invalid Date and Time'),
//           content: const Text('Please select a valid date and time.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   Future<void> selectDateTime(BuildContext context) async {
//     final DateTime? pickedDateTime = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDateTime != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           selectedDateTime = DateTime(
//             pickedDateTime.year,
//             pickedDateTime.month,
//             pickedDateTime.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Schedule Notification'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () => selectDateTime(context),
//               child: const Text('Select Date and Time'),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               selectedDateTime != null
//                   ? 'Selected Date and Time: $selectedDateTime'
//                   : 'No date and time selected',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: scheduleNotification,
//               child: const Text('Schedule Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
