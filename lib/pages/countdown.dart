import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountDown extends StatefulWidget {
  static const String routeName = '/countdown';

  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer? timer;
  void initState() {
    super.initState();
    calculateCountdowns();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        calculateCountdowns();
      });
    });
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: countdowns.length,
        itemBuilder: (context, index) {
          final formattedDate =
              DateFormat('dd/MM/yyyy').format(targetDates[index]);
          return ListTile(
            title: Text('Date: $formattedDate'),
            subtitle: Text('Countdown: ${countdowns[index]}'),
          );
        },
      ),
    );
  }
}

List<DateTime> targetDates = [
  DateTime(2023, 9, 29),
  DateTime(2023, 10, 13),
  DateTime(2023, 10, 26),
  DateTime(2023, 11, 11),
  DateTime(2023, 11, 28),
];

List<String> countdowns = [];

void calculateCountdowns() {
  final now = DateTime.now();
  countdowns = targetDates.map((targetDate) {
    final difference = targetDate.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;
    return '$days days $hours:$minutes:$seconds';
  }).toList();
}
