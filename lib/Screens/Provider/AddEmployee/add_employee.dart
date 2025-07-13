import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/Screens/Provider/AddEmployee/bloc/add_employee_bloc.dart';
import 'package:glowup/Screens/Provider/Employees/my_employee_screen.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<AddEmployeeBloc>();
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 52.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyEmployeeScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.goldenPeach),
                  ),
                ),
                SizedBox(height: 48.h),
                Text(
                  context.tr("Add New Employee"),
                  style: AppFonts.semiBold24,
                ),

                SizedBox(height: 48.h),

                CustomBackgroundContainer(
                  childWidget: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Form(
                        key: bloc.formKey,
                        child: Column(
                          children: [
                            CustomTextfield(
                              textFieldHint: context.tr("Employee Name"),
                              textFieldcontroller: bloc.nameController,
                              validationMethod: (value) {
                                final error = bloc.nameValidation(text: value);
                                error == null ? null : context.tr(error);
                              },
                            ),
                            SizedBox(height: 12.h),
                            CustomTextfield(
                              textFieldHint: context.tr("Employee Bio"),
                              textFieldcontroller: bloc.bioController,
                              validationMethod: (value) {
                                final error = bloc.bioValidation(text: value);
                                error == null ? null : context.tr(error);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: 200,
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: context.tr("Submit"),
                  onTap: () {
                    bloc.add(SubmitEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
