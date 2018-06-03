import 'package:flutter/material.dart';
import 'dart:async';

Future showDateTimePicker(BuildContext context, DateTime initialDate) {
  final Completer completer = new Completer();

  showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: initialDate,
    lastDate: initialDate.add(new Duration(days: 770))
  ).then((DateTime date) {
    showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now()
    ).then((TimeOfDay time) {
      DateTime preciseDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      completer.complete(preciseDate);
    }).catchError((Error error) {
      completer.completeError(error);
    });
  }).catchError((Error error) {
    completer.completeError(error);
  });

  return completer.future;
}
