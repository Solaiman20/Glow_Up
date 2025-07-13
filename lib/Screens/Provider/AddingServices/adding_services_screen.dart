import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/Screens/Provider/AddingServices/bloc/adding_services_bloc.dart';
import 'package:glowup/Screens/Provider/NavBar/provider_nav_bar_screen.dart';
import 'package:glowup/Styles/app_colors.dart';

class AddingServicesScreen extends StatelessWidget {
  const AddingServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingServicesBloc(),
      child: BlocBuilder<AddingServicesBloc, AddingServicesState>(
        builder: (context, state) {
          final bloc = context.read<AddingServicesBloc>();
          return BlocListener<AddingServicesBloc, AddingServicesState>(
            listener: (context, state) {
              if (state is ImageChosenState) {
                // Handle image chosen state
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Image selected successfully!")),
                );
              } else if (state is ImagePickingErrorState) {
                // Handle image picking error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error picking image: ${state.errorMessage}"),
                  ),
                );
              } else if (state is ServiceAddedState) {
                // Handle service added state
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Service added successfully!")),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProviderNavBarScreen(),
                  ),
                ); // Go back after adding service
              } else if (state is ServiceAddingErrorState) {
                // Handle service adding error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Error adding service: ${state.errorMessage}",
                    ),
                  ),
                );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Form(
                  key: bloc.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        if (bloc.imagePath == null)
                          DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              radius: Radius.circular(10.r),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                bloc.add(ChoosingAnImageEvent());
                              },
                              child: Container(
                                height: 207.h,
                                width: 230.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file,
                                      size: 50.sp,
                                      color: Colors.grey.withValues(alpha: 0.5),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      context.tr(
                                        "Press To Upload Service Image",
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (bloc.imagePath != null)
                          GestureDetector(
                            onTap: () {
                              bloc.add(ChoosingAnImageEvent());
                            },
                            child: Container(
                              height: 207.h,
                              width: 230.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Image.file(
                                File(bloc.imagePath!),
                                height: 143.h,
                                width: 335.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(height: 20.h),
                        CustomTextfield(
                          textFieldHint: context.tr("Service Name"),
                          textFieldcontroller: bloc.nameController,
                          validationMethod: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr("Please enter a service name");
                            }
                            return null;
                          },
                        ),
                        CustomTextfield(
                          textFieldHint: context.tr("Bio"),
                          textFieldcontroller: bloc.descriptionController,
                          validationMethod: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr("Please enter a bio");
                            }
                            return null;
                          },
                        ),
                        CustomTextfield(
                          textFieldHint: context.tr("Duration (in minutes)"),
                          textFieldcontroller: bloc.durationController,
                          validationMethod: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr("Please enter a duration");
                            }
                            return null;
                          },
                        ),
                        CustomTextfield(
                          textFieldHint: context.tr("Price"),
                          textFieldcontroller: bloc.priceController,
                          validationMethod: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                double.tryParse(value) == null) {
                              return context.tr("Please enter a price");
                            } else if (double.parse(value) <= 0) {
                              return context.tr(
                                "Price must be greater than zero",
                              );
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 250.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr(
                                      "Please select a category",
                                    );
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: context.tr("Category"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                ),
                                value: bloc.slectedCategory,
                                items:
                                    <String>[
                                      'Hair'.tr(),
                                      'Nails'.tr(),
                                      'Skin'.tr(),
                                      'Makeup'.tr(),
                                      'Other'.tr(),
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value.tr()),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  bloc.slectedCategory = newValue;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CheckboxListTile(
                            title: Text(context.tr("At Home Service")),
                            value: bloc.isAtHome,
                            onChanged: (value) {
                              bloc.add(AtHomeToggleEvent(value!));
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            context.tr("Select Stylists"),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Add your stylist selection widget here
                        ...List.generate(
                          bloc.supabase.theProvider!.stylists.length,
                          (index) {
                            final stylist =
                                bloc.supabase.theProvider!.stylists[index];
                            return Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ChoiceChip(
                                  label: Text(stylist.name),
                                  selectedColor: AppColors.goldenPeach,
                                  backgroundColor: AppColors.calendarDay,
                                  selected: bloc.selectedStylists.contains(
                                    stylist,
                                  ),
                                  onSelected: (selected) {
                                    if (!bloc.selectedStylists.contains(
                                      stylist,
                                    )) {
                                      bloc.selectedStylists.add(stylist);
                                      bloc.add(ChoosingAStylistEvent());
                                      log("selected");
                                    } else {
                                      bloc.selectedStylists.remove(stylist);
                                      log("unselected");
                                      bloc.add(ChoosingAStylistEvent());
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),

                        CustomElevatedButton(
                          text: context.tr("Add Service"),
                          onTap: () async {
                            if (bloc.formKey.currentState!.validate() &&
                                bloc.imagePath != null &&
                                bloc.slectedCategory != null &&
                                bloc.selectedStylists.isNotEmpty) {
                              // Handle form submission
                              bloc.add(AddingServiceEvent());
                              await Future.delayed(Duration(seconds: 2), () {
                                bloc.add(UpdateUIEvent());
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
