import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Providers/provider_card.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';
import 'package:glowup/Screens/Customer/Providers/bloc/providers_bloc.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProvidersBloc(),
      child: BlocBuilder<ProvidersBloc, ProvidersState>(
        builder: (context, state) {
          final bloc = context.read<ProvidersBloc>();
          final providers = bloc.supabase.providers;
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 96.h),
                Row(
                  children: [
                    SizedBox(width: 32.w),
                    CustomSearchBar(
                      controller: TextEditingController(),
                      hintText: "Search providers",
                      onChanged: (value) {
                        // Implement search functionality here
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 402.w,
                  height: 720.h,
                  child: ListView.builder(
                    itemCount: providers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: ProviderCard(provider: providers[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
