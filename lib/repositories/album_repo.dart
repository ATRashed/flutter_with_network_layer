import 'package:flutter/foundation.dart';

import '../models/album_model.dart';
import '../network_module/api_path.dart';
import '../network_module/http_client.dart';

class AlbumRepository {
  Future<Album> fetchAlbumDetails() async {
    final response = await HttpClient.instance
        .fetchData(APIPathHelper.getValue(APIPath.fetch_album));
    if (kDebugMode) {
      print("Response - $response");
    }
    return Album.fromJson(response);
  }
}
