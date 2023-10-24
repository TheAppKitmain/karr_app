import 'package:flutter/material.dart';
import 'package:kaar/controller/home/HomeScreen.dart';

class TicketSubmissionDialog extends StatefulWidget {
  final bool isSuccessful;

  TicketSubmissionDialog({required this.isSuccessful});

  @override
  _TicketSubmissionDialogState createState() =>
      _TicketSubmissionDialogState();
}

class _TicketSubmissionDialogState extends State<TicketSubmissionDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Show animation if the ticket submission is successful
          if (widget.isSuccessful)
          // Add your success animation widget here

          // Show text indicating the result
            Text(
              widget.isSuccessful
                  ? "Ticket Submitted Successfully"
                  : "Ticket Submission Failed",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          // Button to go to the home screen
          ElevatedButton(
            onPressed: () {
              // Navigate to the home screen
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => HomeScreen(key: ,)),
              // );
            },
            child: Text("Go to Home Screen"),
          ),
        ],
      ),
    );
  }
}
