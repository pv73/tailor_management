import "package:dropdown_textfield/dropdown_textfield.dart";
import "package:flutter/material.dart";
import "package:tailor/ui_helper.dart";

//==== If Select Salary option in Tailor Category Sampling filed ============
class Sampling_Salary_Widget extends StatelessWidget {
  final List<DropDownValueModel> dropDownList;
  final String? hint;
  final dynamic list_Controller;
  final void Function(dynamic)? onChanged;
  final String? select_Category;
  final TextEditingController? SalaryController;

  Sampling_Salary_Widget({
    required this.dropDownList,
    required this.list_Controller,
    required this.onChanged,
    required this.SalaryController,
    this.select_Category,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Custom_DropDownTextField(
              hint: hint,
              controller: list_Controller,
              dropDownList: dropDownList,
              onChanged: onChanged,
            ),
          ),
        ),

        // If Salary is Yes then fill Salary in Tailor Category dropdown
        select_Category == "Salary"
            ? Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: TextFormField(
                    controller: SalaryController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    decoration: mInputDecoration(
                      padding: EdgeInsets.only(top: 3, left: 10),
                      radius: 5,
                      hint: "Amount (INR)",
                      hintColor: AppColor.textColorLightBlack,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}





//==== If Select Salary option in Tailor Category Production filed ============
class Production_Salary_Widget extends StatelessWidget {
  final List<DropDownValueModel> dropDownList;
  final String? hint;
  final dynamic list_Controller;
  final void Function(dynamic)? onChanged;
  final TextEditingController? TextController;

  Production_Salary_Widget({
    required this.dropDownList,
    required this.list_Controller,
    required this.onChanged,
    required this.TextController,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Custom_DropDownTextField(
              hint: hint,
              controller: list_Controller,
              dropDownList: dropDownList,
              onChanged: onChanged,
            ),
          ),
        ),
        widthSpacer(),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: TextController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              decoration: mInputDecoration(
                padding: EdgeInsets.only(top: 3, left: 10),
                radius: 5,
                hint: "Amount *",
                hintColor: AppColor.textColorLightBlack,
                mCounterText: "",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
