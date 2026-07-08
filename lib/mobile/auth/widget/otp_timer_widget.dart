import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimerWidget extends StatefulWidget {
  final int duration;
  final VoidCallback onResend;

  const OtpTimerWidget({
    super.key,
    this.duration = 30,
    required this.onResend,
  });

  @override
  State<OtpTimerWidget> createState() =>
      _OtpTimerWidgetState();
}

class _OtpTimerWidgetState
    extends State<OtpTimerWidget> {

  late int seconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    seconds = widget.duration;

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds <= 0) {
          timer.cancel();
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (seconds > 0) {
      return Text(
        "Resend OTP in $seconds sec",
        style: const TextStyle(
          color: Colors.grey,
        ),
      );
    }

    return TextButton(
      onPressed: () {
        widget.onResend();
        startTimer();
      },
      child: const Text(
        "Resend OTP",
      ),
    );
  }
}