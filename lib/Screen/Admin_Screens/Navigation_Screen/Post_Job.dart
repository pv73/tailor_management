import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Company_Details.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Experience_Filed_Widget.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/ImageUpload_Field.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Multi_And_Single_btn.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Tailor_Category_All_Filed.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Veriables_And_Function.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/dynimic_list/Job_Dropdown_list.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/JobModel.dart';
import 'package:tailor/ui_helper.dart';
import 'package:uuid/uuid.dart';

class Post_Job extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;
  final bool isButtonClick;

  Post_Job({super.key, required this.firebaseUser, required this.companyModel, this.isButtonClick = false});

  @override
  State<Post_Job> createState() => _Post_JobState();
}

class _Post_JobState extends State<Post_Job> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        leading: widget.isButtonClick == false
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Navigate back when back button is pressed
                  Navigator.pop(context);
                },
              ),
        title: RichText(
          text: TextSpan(
              text: "Post ",
              style: mTextStyle20(),
              children: [TextSpan(text: "new job", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
        ),
      ),
      drawer: !widget.isButtonClick
          ? Drawer_Widget(isCurUserCom: true, firebaseUser: widget.firebaseUser, companyModel: widget.companyModel)
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text
            Padding(
              padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 0),
              child: Text(
                "Post your new job for users",
                style: mTextStyle16(mFontWeight: FontWeight.w800),
              ),
            ),
            heightSpacer(mHeight: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Fill all fields to upload job",
                style: mTextStyle13(mColor: AppColor.textColorLightBlack, mFontWeight: FontWeight.w500),
              ),
            ),

            /// Form
            heightSpacer(),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    // ========== Company Details ExpansionTile =============
                    Custom_ExpansionTile(
                      collapsedBackgroundColor: Color(0x47BEDFFF),
                      title: Text(
                        "Company Details",
                        style: mTextStyle14(mFontWeight: FontWeight.w600),
                      ),
                      children: [
                        CompanyDetailsComponents(
                          firebaseUser: widget.firebaseUser,
                          companyModel: widget.companyModel,
                        )
                      ],
                    ),

                    // Job Details ExpansionTile
                    heightSpacer(),
                    Custom_ExpansionTile(
                      // By default open this ExpansionTile when loaded
                      initiallyExpanded: true,
                      collapsedBackgroundColor: detailsErrorColor != null ? detailsErrorColor : Color(0x47BEDFFF),
                      backgroundColor: detailsErrorColor != null ? detailsErrorColor : Colors.grey.shade50,
                      title: RichText(
                        text: TextSpan(
                          text: "Job Details ",
                          style: mTextStyle14(mFontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " *",
                              style: mTextStyle14(mFontWeight: FontWeight.w800, mColor: Colors.red),
                            )
                          ],
                        ),
                      ),
                      children: [
                        // ================== GARMENT TYPE ==========
                        Custom_DropDownTextField(
                          hint: "Garment Type *",
                          controller: garment_value,
                          dropDownList: garment_Option,
                          onChanged: (value) {
                            if (value != null) {
                              garment = garment_value.dropDownValue?.name;
                              detailsErrorColor = null;
                            } else {
                              garment = null;
                            }
                            setState(() {});
                          },
                        ),

                        // =========== Upload Garment Image ===========
                        ImageUpload_field(
                          padding: EdgeInsets.only(top: 10),
                          selected_pic: garment_Pic,
                          hintText: "Garment Image",
                          ImageName: garmentPicName,
                          Upload: () {
                            Image_Picker_showBottomSheet(context, fromCameraPress: () {
                              pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            }, fromGalleryPress: () {
                              pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            });
                          },
                        ),

                        // ============== Garment Order ================
                        heightSpacer(),
                        Job_TextField(
                          controller: garmentQtyController,
                          Text_Hint: "Garment Order Quantity",
                          onChanged: (value) {},
                        ),

                        // ============== Work place Type ==================
                        heightSpacer(),
                        Multi_And_Single_Btn(
                          heading_Text: "Work Place Type",
                          isRequired_start: " *",
                          isRadio: true,
                          buttons: [
                            "Onsite",
                            "Work from home",
                          ],
                          onSelected: (work_btn_name, index, isSelected) {
                            setState(() {
                              work_Type = work_btn_name;
                              detailsErrorColor = null;
                            });
                          },
                        ),

                        // ============== Work Shift ==================
                        heightSpacer(),
                        Multi_And_Single_Btn(
                          heading_Text: "Work Shift",
                          isRequired_start: " *",
                          isRadio: true,
                          buttons: [
                            "Day Shift",
                            "Night Shift",
                          ],
                          onSelected: (shift_btn_name, index, isSelected) {
                            setState(() {
                              work_Shift = shift_btn_name;
                              detailsErrorColor = null;
                            });
                          },
                        ),

                        // ============== Job Type ==================
                        heightSpacer(),
                        Custom_DropDownTextField(
                          hint: "Job Type *",
                          controller: job_type_value,
                          dropDownList: job_Type_Option,
                          onChanged: (value) {
                            if (value != null) {
                              job_Type = job_type_value.dropDownValue?.name;
                              // error Color null
                              detailsErrorColor = null;
                            } else {
                              job_Type = null;
                            }
                            setState(() {});
                          },
                        ),

                        // ============ Tailor Department ===============
                        heightSpacer(),
                        Custom_DropDownTextField(
                          hint: "Tailor Department *",
                          controller: department_value,
                          dropDownList: department_Option,
                          onChanged: (value) {
                            if (value != null) {
                              department = department_value.dropDownValue?.name;
                              detailsErrorColor = null;
                            } else {
                              department = null;
                            }

                            setState(() {
                              // Close the dropdown list when the education value changes
                              FocusScope.of(context).requestFocus(FocusNode());
                              String? isDepEqTo = department_value.dropDownValue?.value;

                              if (isDepEqTo == "Sampling") {
                                currentCategoryOptions = sampling_Alter_Option;
                                ProSalaryEmptyFields();
                                PartRateEmptyFields();
                                FullPcEmptyFields();
                                category_value.clearDropDown();
                                category = null;
                              } else if (isDepEqTo == "Production") {
                                currentCategoryOptions = production_Option;
                                // Clear Field Sampling
                                SamplingEmptyFields();
                              } else if (isDepEqTo == "Finishing") {
                                currentCategoryOptions = sampling_Alter_Option;
                                ProSalaryEmptyFields();
                                PartRateEmptyFields();
                                FullPcEmptyFields();
                                category_value.clearDropDown();
                                category = null;
                              } else {
                                currentCategoryOptions;
                              }
                            });
                          },
                        ),

                        // Only Show when Selected Simpling and Finishing in Department
                        department == "Sampling" || department == "Finishing"
                            ? Column(
                                children: [
                                  Sampling_Salary_Widget(
                                    hint: "Tailor Category",
                                    select_Category: category,
                                    list_Controller: category_value,
                                    dropDownList: currentCategoryOptions,
                                    SalaryController: sampling_SalaryController,
                                    onChanged: (value) {
                                      if (value != null) {
                                        category = category_value.dropDownValue?.name;
                                      } else {
                                        category = null;
                                      }
                                      setState(() {
                                        // Empty Field part category
                                        if (category == "Salary") {
                                          partTime_Cat_value.clearDropDown();
                                          partTime_Cat = null;
                                          partTime_Sub_Cat_value.clearDropDown();
                                          partTime_Sub_Cat = null;
                                        } else {
                                          sampling_SalaryController.text = "";
                                        }
                                      });
                                    },
                                  ),

                                  // Hear write for Part Time Sub Category - Pc Rate and Hourly Basis
                                  category == "Part Time"
                                      ? Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Custom_DropDownTextField(
                                            hint: "Part Time Sub Category",
                                            controller: partTime_Cat_value,
                                            dropDownList: part_Time_Option,
                                            onChanged: (value) {
                                              if (value != null) {
                                                partTime_Cat = partTime_Cat_value.dropDownValue?.name;
                                              } else {
                                                partTime_Cat = null;
                                              }

                                              setState(() {
                                                // Close the dropdown list when the education value changes
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                String isSubCatEqTo = partTime_Cat_value.dropDownValue?.value;

                                                if (isSubCatEqTo == "PC_Rate") {
                                                  currentPartTimeSubCatOptions = pc_Rate_Option;
                                                  partTime_Sub_Cat_value.clearDropDown();
                                                  partTime_Sub_Cat = null;
                                                } else if (isSubCatEqTo == "Hourly_Basis") {
                                                  currentPartTimeSubCatOptions = hourly_Base_Option;
                                                  partTime_Sub_Cat_value.clearDropDown();
                                                  partTime_Sub_Cat = null;
                                                } else {
                                                  currentPartTimeSubCatOptions;
                                                }
                                              });
                                            },
                                          ),
                                        )
                                      : Container(),

                                  // ============== If selected Pc RAte in Part Time Cat ==================
                                  partTime_Cat == "PC Rate" || partTime_Cat == "Hourly Basis"
                                      ? Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Custom_DropDownTextField(
                                            hint: "Select Option",
                                            controller: partTime_Sub_Cat_value,
                                            dropDownList: currentPartTimeSubCatOptions,
                                            onChanged: (value) {
                                              if (value != null) {
                                                partTime_Sub_Cat = partTime_Sub_Cat_value.dropDownValue?.name;
                                                // Empty Field partT_Sub_Cat_Controller
                                                partT_Sub_Cat_Controller.text = "";
                                              } else {
                                                partTime_Sub_Cat = null;
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        )
                                      : Container(),

                                  // ============== If any Selected partTime_Sub_Cat then add one Text Filed ==================
                                  partTime_Sub_Cat != null
                                      ? Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Job_TextField(
                                            controller: partT_Sub_Cat_Controller,
                                            keyboardType: partTime_Sub_Cat == "Time Slot" ? TextInputType.text : TextInputType.number,
                                            Text_Hint: partTime_Sub_Cat == "Time Slot" ? "09:30 AM - 6:30 PM" : "Amount (INR)",
                                            onChanged: (value) {},
                                          ))
                                      : Container(),
                                ],
                              )
                            : Container(),

                        // Only Show when Selected Production in Department
                        department == "Production"
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Custom_DropDownTextField(
                                      hint: "Tailor Category *",
                                      controller: category_value,
                                      dropDownList: currentCategoryOptions,
                                      onChanged: (value) {
                                        if (value != null) {
                                          category = category_value.dropDownValue?.name;
                                        } else {
                                          // Handle the case when nothing is selected
                                          category = null;
                                        }

                                        String? pro_cat = category_value.dropDownValue?.value;

                                        if (pro_cat == "Pro_Salary") {
                                          // Empty Part Rate and Full Pc
                                          PartRateEmptyFields();
                                          FullPcEmptyFields();
                                        } else if (pro_cat == "Part_Rate") {
                                          // Empty Pro Salary and Full Pc
                                          ProSalaryEmptyFields();
                                          FullPcEmptyFields();
                                        } else {
                                          // Empty Pro Salary and Part Rate
                                          ProSalaryEmptyFields();
                                          PartRateEmptyFields();
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),

                                  // This Salary Part only visible If selected salary in Production Department
                                  category_value.dropDownValue?.value == "Pro_Salary"
                                      ? Production_Salary_Widget(
                                          hint: "Grade Salary",
                                          list_Controller: grade_Salary_value,
                                          dropDownList: salary_Option,
                                          TextController: grade_Salary_Controller,
                                          onChanged: (value) {
                                            if (value != null) {
                                              grade_Salary = grade_Salary_value.dropDownValue?.name;
                                              grade_Salary_Controller.text = "";
                                            } else {
                                              grade_Salary = null;
                                            }
                                          },
                                        )
                                      : Container(),

                                  // This Option Part only visible If selected Part Rate in Production Department
                                  category == "Part Rate"
                                      ? Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Custom_DropDownTextField(
                                                hint: "Select Option",
                                                controller: part_Rate_value,
                                                dropDownList: part_Rate_Option,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // Close the dropdown list when the education value changes
                                                    FocusScope.of(context).requestFocus(FocusNode());

                                                    if (value != null) {
                                                      String? isPartRateEqTo = part_Rate_value.dropDownValue?.value;

                                                      if (isPartRateEqTo == "part_rate_excel") {
                                                        part_Rate = "Part rate excel";
                                                        PartRateImgEmptyFields();
                                                      } else if (isPartRateEqTo == "part_rate_image") {
                                                        part_Rate = "Part rate image";
                                                        PartRateImgEmptyFields();
                                                      } else if (isPartRateEqTo == "part_rate_text") {
                                                        part_Rate = "Part rate text";
                                                        PartRateImgEmptyFields();
                                                      } else {
                                                        part_Rate = null;
                                                      }
                                                    } else {
                                                      part_Rate = null;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),

                                            // If Selected part Rate Excel and part Rate Image
                                            part_Rate == "Part rate excel" || part_Rate == "Part rate image"
                                                ? ImageUpload_field(
                                                    padding: EdgeInsets.only(top: 10),
                                                    ImageName: partRateUrlName,
                                                    selected_pic: partRateUrl,
                                                    hintText: part_Rate == "Part rate excel" ? "Upload excel file" : "Picture upload",
                                                    Upload: part_Rate == "Part rate excel"
                                                        ? () {
                                                            // Select Excel File
                                                            _pickExcelFile();
                                                          }
                                                        : () {
                                                            // Select Image
                                                            Image_Picker_showBottomSheet(context, fromCameraPress: () {
                                                              pickImage(ImageSource.camera);
                                                              Navigator.pop(context);
                                                            }, fromGalleryPress: () {
                                                              pickImage(ImageSource.gallery);
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                  )
                                                : Container(),

                                            // If Selected part Rate Text
                                            part_Rate == "Part rate text"
                                                ? Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Job_TextField(
                                                      controller: part_Rate_Text_Controller,
                                                      Text_Hint: "Part Rate Text",
                                                      keyboardType: TextInputType.multiline,
                                                      onChanged: (value) {},
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        )
                                      : Container(),

                                  // This Per PC Rate only visible If selected Full PC in Production Department
                                  category == "Full PC"
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: Custom_DropDownTextField(
                                                  hint: "Select Option",
                                                  controller: full_Pc_value,
                                                  dropDownList: full_Pc_Option,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      full_Pc = full_Pc_value.dropDownValue?.name;
                                                    } else {
                                                      full_Pc = null;
                                                    }
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),

                                            // ======== If Per_PC_Rate selected ==================
                                            full_Pc != null
                                                ? Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 10, left: 5),
                                                      child: Job_TextField(
                                                        controller: full_Pc_Controller,
                                                        Text_Hint: "Amount",
                                                        onChanged: (value) {},
                                                      ),
                                                    ))
                                                : Container(),
                                          ],
                                        )
                                      : Container(),
                                ],
                              )
                            : Container(),
                      ],
                    ),

                    // ============= Total Tailor & Skills =============
                    heightSpacer(),
                    Custom_ExpansionTile(
                      collapsedBackgroundColor: totalTailorErrorColor != null ? totalTailorErrorColor : Color(0x47BEDFFF),
                      backgroundColor: totalTailorErrorColor != null ? totalTailorErrorColor : Colors.grey.shade50,
                      title: RichText(
                        text: TextSpan(
                          text: "Required workers as per Skills",
                          style: mTextStyle14(mFontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " *",
                              style: mTextStyle14(mFontWeight: FontWeight.w800, mColor: Colors.red),
                            )
                          ],
                        ),
                      ),
                      children: [
                        // Total Tailor
                        job_Type == null
                            ? Container()
                            : Job_TextField(
                                controller: totalTailorController,
                                Text_Hint: "Total ${job_Type} Employee *",
                                onChanged: (value) {
                                  setState(() {
                                    totalTailorErrorColor = null;
                                  });
                                },
                              ),

                        /// Only Show if jobType null and tailor selected Skills Button
                        job_Type == "Tailor" || job_Type == null
                            ? Card_Container_Widget(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.all(8),
                                mBorderColor: AppColor.textColorLightBlack,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Select Tailor Skills ",
                                        style: mTextStyle14(mFontWeight: FontWeight.w600),
                                      ),
                                    ),

                                    // Skills
                                    heightSpacer(),
                                    GroupButton(
                                      options: mAdminPageGroupButtonOptions(),
                                      isRadio: false,
                                      buttons: [
                                        "Single Needle Operator",
                                        "Feedup Machine Operator",
                                        "Cutting Machine Operator",
                                        "Consie Machine Operator",
                                        "Bartack Machine Operator",
                                        "Flatlock Operator",
                                        "Overlock Operator",
                                        "Other"
                                      ],
                                      onSelected: (skills_btn_name, index, isSelected) {
                                        // call This Method
                                        _SelectedSkillMethod(skills_btn_name, index, isSelected);
                                      },
                                    ),

                                    // Show Skills TextController list
                                    Container(
                                      child: Column(
                                        children: List.generate(selectedSkills.length, (index) {
                                          final skill = selectedSkills[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Job_TextField(
                                              controller: selectedSkillsControllers[index],
                                              Text_Hint: "${skill} Employee",
                                              onChanged: (value) {
                                                // Update the corresponding value in the enteredTexts list
                                                selectedSkillsEmployee[index] = value;
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    // ======== Experience ============
                    heightSpacer(),
                    Custom_ExpansionTile(
                      collapsedBackgroundColor: Color(0x47BEDFFF),
                      backgroundColor: Colors.grey.shade50,
                      title: RichText(
                        text: TextSpan(
                          text: "Experience",
                          style: mTextStyle14(mFontWeight: FontWeight.w600),
                        ),
                      ),
                      children: [
                        Row(
                          children: [
                            Experience_Filed_Widget(
                              mTitle: "Minimum",
                              mHintText: "Mini. (in years)",
                              textController: expMiniController,
                              onChanged: (value) {},
                            ),
                            widthSpacer(),
                            Experience_Filed_Widget(
                              mTitle: "Maximum",
                              mHintText: "Maxi. (in years)",
                              textController: expMaxiController,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Job Submit Button
                    heightSpacer(mHeight: 10),
                    BlocConsumer<JobPostCubit, JobPostState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        showSnackBar_Widget(
                          context,
                          mHeading: "Success",
                          title: "Your form is submitted successfully",
                        );
                        isSubmit_ClearFormFields();
                        setState(() {});
                      },
                      builder: (context, state) {
                        if (state is JobPostLoadingState || isLodding == true) {
                          return Center(
                            child: Lottie.asset("assets/images/lottie_animation/loading-2.json", width: 60),
                          );
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Rounded_Btn_Widget(
                            mfontSize: 15,
                            mAlignment: Alignment.center,
                            borderRadius: 5,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                _SubmitPostButton();
                              }
                            },
                            title: "Submit ",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //============ Skills Selected function ==========
  void _SelectedSkillMethod(skills_btn_name, index, isSelected) {
    setState(() {
      if (isSelected) {
        selectedSkills.add(skills_btn_name);
        selectedSkillsControllers.add(TextEditingController()); // Add TextEditingController for each selected skill
        selectedSkillsEmployee.add('0'); // Add an 0 string for each selected skill
        detailsErrorColor = null;
      } else {
        final selectedIndex = selectedSkills.indexOf(skills_btn_name);
        if (selectedIndex != -1) {
          selectedSkills.removeAt(selectedIndex);
          selectedSkillsControllers[selectedIndex].dispose();
          selectedSkillsControllers.removeAt(selectedIndex);
          selectedSkillsEmployee.removeAt(selectedIndex); // Remove the corresponding entered text
        }
      }

      // log(selectedSkills.toString());
      // log(selectedSkillsEmployee.toString());
    });
  }

// TODO: ============ Pick Image Function ================

  pickImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      if (part_Rate == "Part rate image") {
        partRateImagePath = pickedFile.path;
        partRateUrlName = pickedFile.name;
      } else {
        garmentImagePath = pickedFile.path;
        garmentPicName = pickedFile.name;
      }
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      // aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 15,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);

      setState(() {
        if (part_Rate == "Part rate image") {
          partRateUrl = newFile;
        } else {
          garment_Pic = newFile;
        }
      });
    }
  }

  //TODO ==================== Pick Excel File ================
  void _pickExcelFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      partRateUrl = File(pickedFile.files.single.path!);
      partRateImagePath = pickedFile.files[0].path;

      // Check if the file size is less than or equal to 2 MB
      if (partRateUrl!.lengthSync() <= 2 * 1024 * 1024) {
        setState(() {
          partRateUrlName = pickedFile.files[0].name;
          partRateExcelError = null;
        });
      } else {
        setState(() {
          partRateExcelError = "Please Upload file less than 2 MB";
        });
      }
    }
  }

  //TODO ============ Upload File and all data ================
  void _SubmitPostButton() async {
    try {
      if (garment != null &&
          work_Type != null &&
          work_Shift != null &&
          job_Type != null &&
          department != null &&
          category != null &&
          totalTailorController.text.isNotEmpty) {
        setState(() {
          isLodding = true;
        });

        // upload Garment Image and Part Rate image
        if (garment_Pic != null) {
          garmentUploadTask = FirebaseStorage.instance
              .ref()
              .child("job_documents")
              .child("garment_images")
              .child(garmentPicName!)
              .putFile(garment_Pic!);

          TaskSnapshot? garmentTaskSnapshot = await garmentUploadTask;
          garment_downloadUrl = await garmentTaskSnapshot?.ref.getDownloadURL();
        }

        // upload Part Rate  Image
        if (partRateUrl != null) {
          pTFileUploadTask = FirebaseStorage.instance
              .ref()
              .child("job_documents")
              .child("part_rate_images")
              .child(partRateUrlName!)
              .putFile(partRateUrl!);

          TaskSnapshot? partRateTaskSnapshot = await pTFileUploadTask;
          partRate_downloadUrl = await partRateTaskSnapshot?.ref.getDownloadURL();
        }

        /// upload in CompanyModel data
        JobPostModel newJobPost = JobPostModel(
            dateTime: DateTime.now(),
            uid: widget.companyModel.uid,
            jobId: Uuid().v4(),
            company_logo: widget.companyModel.company_logo,
            company_name: widget.companyModel.company_name,
            company_address: widget.companyModel.address,
            garment_type: garment,
            garment_image: garment_downloadUrl,
            garmentPicName: garmentPicName,
            garment_order: garmentQtyController.text,
            work_type: work_Type,
            work_shift: work_Shift,
            job_type: job_Type,
            department: department,
            category: category,
            samp_salary: sampling_SalaryController.text,
            part_time_category: partTime_Cat,
            part_time_sub_cat: partTime_Sub_Cat,
            pt_sub_cat_text: partT_Sub_Cat_Controller.text,
            grade_salary: grade_Salary,
            grade_salary_amount: grade_Salary_Controller.text,
            part_rate: part_Rate,
            part_rate_text: part_Rate_Text_Controller.text,
            part_rate_url: partRate_downloadUrl,
            part_rate_url_name: partRateUrlName,
            full_pc: full_Pc,
            full_pc_amount: full_Pc_Controller.text,
            total_tailor: totalTailorController.text,
            minimum_experience: expMiniController.text,
            maximum_experience: expMaxiController.text,
            tailor_skill: selectedSkills,
            skills_tailor_employee: selectedSkillsEmployee);

        BlocProvider.of<JobPostCubit>(context).addJobPostModel(newJobPost);

        setState(() {
          isLodding = false;
        });
      } else {
        //first check filed is not empty then change Expansion color
        CheckFieldThenChangeColor();

        showSnackBar_Widget(
          context,
          mHeading: "Error",
          title: "Some field is empty",
        );
        setState(() {});
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
