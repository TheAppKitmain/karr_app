import 'package:flutter/cupertino.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';

class ReviewDetailScreen extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final String pcn_nmuber;
  final String date;
  final String charge;
  ReviewDetailScreen({required this.onPrevious, required this.onNext, required this.pcn_nmuber, required this.date, required this.charge});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Review Details",
              style: TextStyle(
              color: AppColors.black,
              fontFamily: "Lato",
              fontSize: width * 0.07,
            ),),
            SizedBox(height: height*0.02,),
            Text("Please confirm the details below are correct before submitting.",
              style: TextStyle(
              color: AppColors.black,
              fontFamily: "Lato-Regular",
              fontSize: width * 0.04,
            ),),
            SizedBox(height: height*0.07,),

            ParkingTicketCard(pcnNumber: pcn_nmuber, status: "status", date: date, price: charge)
          ],
        ),
      ),
    );
  }
}
