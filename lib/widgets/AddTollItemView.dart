import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddNoteDialog.dart';

class AddTollsItemView extends StatefulWidget {
  final Toll tolls;
  final Function(Toll, bool) onTollChecked;

  const AddTollsItemView({
    Key? key,
    required this.tolls,
    required this.onTollChecked,
  }) : super(key: key);

  @override
  _AddTollsItemViewState createState() => _AddTollsItemViewState();
}

class _AddTollsItemViewState extends State<AddTollsItemView> {
  bool _rememberMe = false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.tolls.name}',
                      style: TextStyle(color: AppColors.black, fontSize: width * 0.04, fontFamily: "Lato"),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${widget.tolls.days}',
                      style: TextStyle(color: AppColors.black, fontSize: width * 0.035, fontFamily: "Lato-Regular"),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        AddNoteDialog.show(context, "Successfully Added", (v) {
                          widget.tolls.note = v; //note added for this item
                        });
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Add Note',
                            style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Flexible(
                flex: 1,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    if (mounted)setState(() {
                      _rememberMe = value ?? false;
                      widget.tolls.ischecked = _rememberMe;
                      widget.onTollChecked(widget.tolls, _rememberMe); // Call the callback
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
