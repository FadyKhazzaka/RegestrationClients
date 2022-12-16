import 'dart:io';
import 'api.dart';
void main() async {
  ApiClient apiClient = await ApiClient();
  try {
    int counter = 0;
    while (counter < 4) {
      print("Enter Your Phone Number");
      String? phoneNumber = stdin.readLineSync();
      if (phoneNumber?.length != 11) {
        print('The phone number must be at least 11.');
        counter++;
      }
      String? bearerNumber = await apiClient.register(phoneNumber!);
      print("Enter the Token");
      String? token = stdin.readLineSync();
      bool verified = await apiClient.verify(token!, bearerNumber!);
      while (!verified) {
        print(
            "You have entered the token incorrectly. Do you want to continue? (yes/no)");
        String? choice = stdin.readLineSync();
        if (choice?.toUpperCase() == "yes".toUpperCase()) {
          print("Enter the Token");
          String? messageToken = stdin.readLineSync();
          ApiClient apiClients = await ApiClient();
          verified = await apiClients.verify(messageToken!, bearerNumber);
        } else {
          print("ThankYou");
          return;
        }
      }
      if (verified) {
        print('Your Mobile Number Has Been Verified');
      }
    }
  } catch (e) {
    print("Check your internet connection, and try again ");
  }
}
