import 'package:e_delivery/service/api_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part "providers.g.dart";
// part 'main.g.dart';

@riverpod
Future getDeliveryNote(GetDeliveryNoteRef ref,
    {required String staff_id, required String client_id}) {
  final api = ref.watch(repositoryProvider);
  return api.fetchDeliveryNote(staff_id, client_id);
}

@riverpod
Future loginStaff(LoginStaffRef ref,
    {required String email, required String password}) {
  final api = ref.watch(repositoryProvider);
  return api.loginStaff(email, password);
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final myPrefsProvider = Provider<SharedPreferences>((ref) {
  final asyncValue = ref.watch(sharedPreferencesProvider);
  return asyncValue.asData!.value;

});

final myValuesProvider = Provider<List<String>>((ref) {
  final prefs = ref.watch(myPrefsProvider);
  var staff_id = prefs.getString('staff_id');
  var client_id = prefs.getString('client_id');
  return [staff_id!, client_id!];
});

// login provider
 
  


 


 


// @riverpod


 
 
// ignore: avoid_types_as_parameter_names
// final deliverNoteProvider = FutureProvider.family((ref, parameter) async {
  // access the staff_id variable in the DeliveryEqu class


// });

 