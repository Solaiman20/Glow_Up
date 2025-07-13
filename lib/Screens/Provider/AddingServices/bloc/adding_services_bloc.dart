import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'adding_services_event.dart';
part 'adding_services_state.dart';

class AddingServicesBloc
    extends Bloc<AddingServicesEvent, AddingServicesState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? imagePath;
  bool isAtHome = false;
  String? slectedCategory;
  List<Stylist> selectedStylists = [];
  final supabase = GetIt.I.get<SupabaseConnect>();

  AddingServicesBloc() : super(AddingServicesInitial()) {
    on<AddingServicesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChoosingAnImageEvent>((event, emit) async {
      // Logic to choose an image
      // For example, using an image picker package
      try {
        XFile? pickedAvatar = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickedAvatar != null) {
          imagePath = pickedAvatar.path;
          emit(ImageChosenState());
        }
      } catch (e) {
        emit(ImagePickingErrorState(e.toString()));
      }
    });
    on<AtHomeToggleEvent>((event, emit) {
      isAtHome = event.isAtHome;
      emit(AtHomeToggleState());
    });
    on<AddingServiceEvent>((event, emit) async {
      try {
        final addingStatus = await supabase.addService(
          name: nameController.text,
          description: descriptionController.text,
          durationMinutes: int.parse(durationController.text),
          price: double.parse(priceController.text),
          category: slectedCategory!,
          filePath: imagePath!,
          selectedStylists: selectedStylists,
          atHome: isAtHome,
        );
        if (addingStatus) {
          emit(ServiceAddedState());
        } else {
          emit(ServiceAddingErrorState("Failed to add service"));
        }
      } catch (e) {
        emit(ServiceAddingErrorState(e.toString()));
      }
    });
    on<ChoosingAStylistEvent>((event, emit) {
      // Logic to choose a stylist
      // For example, you might want to show a list of stylists and allow the user to select one
      emit(AStylistChosenState());
    });
    on<UpdateUIEvent>((event, emit) => emit(UIUpdateState()));
  }
}
