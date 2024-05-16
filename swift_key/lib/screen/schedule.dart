//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:swift_key/screen/customnavbar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: "Schedule",
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
        profileImagePath: 'assets/avatar.png',
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 2),
        itemBuilder: (_, __) => SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Add border here
              borderRadius: BorderRadius.circular(10), // Add border radius here
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(LineAwesomeIcons.calendar_1),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: Colors.blue, fontWeightDelta: 1),
                          ),
                          Text("07 nov 2024",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    //se poate adauga sa aiba bifa daca a venit la timp, si x daca nu
                    const Icon(LineAwesomeIcons.check),
                  ],
                ),

                const SizedBox(height: 16),
                //row 2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(LineAwesomeIcons.user_clock),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Clock in",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text("09:15",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(LineAwesomeIcons.clipboard_with_check),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Clock out",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Text("17.23",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
