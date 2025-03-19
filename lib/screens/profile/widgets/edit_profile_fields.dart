import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class EditProfileFields extends StatefulWidget {
  final String titleName;
  final String titleValue;
  const EditProfileFields({super.key, required this.titleName, required this.titleValue});

  @override
  State<EditProfileFields> createState() => _EditProfileFieldsState();
}

class _EditProfileFieldsState extends State<EditProfileFields> {
  TextEditingController titleValueController = TextEditingController();
  bool isChanged = false; // Tracks if text has changed

  @override
  void initState() {
    super.initState();
    titleValueController = TextEditingController(text: widget.titleValue);

    // Listen for changes in the text field
    titleValueController.addListener(() {
      setState(() {
        isChanged = titleValueController.text != widget.titleValue;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        leadingWidth:100,
        leading:   TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: largeText16(context, 'Cancel',textColor: appBlackColor,fontWeight:FontWeight.w600,),
        ),
        title: largeText16(context, widget.titleName,fontWeight: FontWeight.bold,fontSize: 20),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              if(isChanged && titleValueController.text.isNotEmpty){
                Navigator.pop(context, titleValueController.text);
              }else{
                if(isChanged)UiHelper.toastMessage("${widget.titleName} Should be empty");
              }
            },

          /*  onPressed: isChanged
                ? () {
              Navigator.pop(context, titleValueController.text); // Return new value
            } : null, */// Disable button if no changes
            child: largeText16(
              context,
              'Save',
              textColor: isChanged ? Colors.red : Colors.grey, // Change color based on changes
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.titleName!="Bio"?
            SizedBox(
              height: 45, // Adjust this value as needed
              child: TextFormField(
                controller: titleValueController,
                style: GoogleFonts.jost(color: Colors.black,fontSize: 16,),
                decoration:  InputDecoration(
                  hintText: widget.titleName,
                  hintStyle: GoogleFonts.jost(color: Colors.grey,fontSize: 16,),
                  contentPadding: const EdgeInsets.symmetric(horizontal:12,vertical: 10.0), // Adjust this value
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      titleValueController.clear();
                    },
                    child: const Icon(Icons.cancel, color: Colors.grey),
                  ),
                ),
              ),
            ):
            Container(
              // height: 134,
              // width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color:appGreyColor, width: 1.0,
                    style: BorderStyle.solid),
              ),
              child: TextFormField(
                controller: titleValueController,
                minLines: 6, // Initial number of lines
                maxLines: null, // Allows the TextFormField to expand dynamically
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: appBlackColor
                ),
                decoration: const InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                    color: appGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border:InputBorder.none,
                  focusedBorder:InputBorder.none,
                  enabledBorder:InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}





