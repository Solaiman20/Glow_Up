import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/Services/provider_service_card.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/Screens/Provider/AddingServices/adding_services_screen.dart';
import 'package:glowup/Screens/Provider/Services/bloc/provider_services_bloc.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderServicesScreen extends StatelessWidget {
  const ProviderServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderServicesBloc(),
      child: BlocBuilder<ProviderServicesBloc, ProviderServicesState>(
        builder: (context, state) {
          log("entered ProviderServicesScreen");
          final bloc = context.read<ProviderServicesBloc>();
          final services = bloc.supabase.theProvider?.services ?? [];
          log(jsonEncode(services));
          log("services length: ${services.length}");
          return BlocListener<ProviderServicesBloc, ProviderServicesState>(
            listener: (context, state) {
              if (state is ServiceDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Service deleted successfully"),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else if (state is ServiceDeletionErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Error deleting service: ${state.errorMessage}",
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(height: 100.h),
                  Text("Your Services", style: AppFonts.bold20),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: CustomElevatedButton(
                      radius: 10.r,
                      icon: Icon(Icons.add, size: 24.sp, color: Colors.white),
                      text: "Add New Service",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddingServicesScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  if (services.isNotEmpty)
                    SizedBox(
                      height: context.getScreenHeight(size: 0.75.h),
                      width: context.getScreenWidth(size: 1.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return Padding(
                            padding: EdgeInsets.all(16.h),
                            child: ProviderServiceCard(
                              service: service,
                              onDelete: () async {
                                bloc.add(
                                  DeleteServiceEvent(serviceId: service.id!),
                                );
                                await Future.delayed(
                                  Duration(milliseconds: 300),
                                  () {
                                    bloc.add(UpdateUIEvent());
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
