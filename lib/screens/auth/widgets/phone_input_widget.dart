import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCountryChanged;
  final String initialCountryCode;

  const PhoneInputWidget({
    super.key,
    required this.controller,
    this.onCountryChanged,
    this.initialCountryCode = 'IN',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        maxLength: 15,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allows only numbers
        ],
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: '987654321',
          labelStyle: GoogleFonts.jost(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
          hintStyle: GoogleFonts.jost(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: const Color(0xffc4c4c4),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Container(
            padding: const EdgeInsets.only(left: 6, top: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                  onChanged: (country) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (onCountryChanged != null) {
                      onCountryChanged!(country.dialCode ?? '');
                    }
                  },
                  initialSelection: initialCountryCode, // Default country (India)
                  favorite: const ['+91'], // Favorite country codes
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(right: 4),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  showFlag: true,
                  flagWidth: 26,
                  showFlagDialog: true,
                  showDropDownButton: false,
                  dialogSize: const Size(double.infinity, 500),
                  textStyle: GoogleFonts.jost(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: const Color(0xffc4c4c4),
                  ),
                  dialogTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 20, right: 10, top: 6, bottom: 10),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          counterText: "",
        ),
      ),
    );
  }
}
