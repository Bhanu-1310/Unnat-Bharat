import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/add_task_screen.dart';
import 'package:medicine_scheduler_app/view/widgets/scheduled_elements.dart';
import 'package:velocity_x/velocity_x.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Hi, $currentUsername".text.size(18).color(Colors.black).make(),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          nextScreen(const AddTaskScreen(), context);
        },
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ToDos')
              // .orderBy("datePublished", descending: true) //some database error is there and so multiple queries are not working
              .where("uid", isEqualTo: currentUserUid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ScheduledElements(
                    snap: snapshot.data!.docs[index].data(),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
