import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();
  static void launchMapFromSourceToDestination(
      sourceLat, sourceLng, destinationLat, destinationLng) async {
    String mapOptions = [
      "saddr=$sourceLat,$sourceLng",
      "daddr=$destinationLat,$destinationLng",
      "dir_action=navigate"
    ].join("&");

    String googleMapURL = "https://www.google.com/maps?$mapOptions";
    Uri mapURL = Uri.parse((googleMapURL));
    if (await canLaunchUrl(mapURL)) {
      await launchUrl(mapURL, mode: LaunchMode.externalApplication);
    } else {
      throw "can't open Maps";
    }
  }
}
