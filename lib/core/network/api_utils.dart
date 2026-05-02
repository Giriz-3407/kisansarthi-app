import 'dart:developer' as dev;

class ApiUtils {
  static List<dynamic> extractList(dynamic data) {
    if (data == null) return [];
    
    if (data is List) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      // Check for common wrapping keys
      if (data.containsKey('records') && data['records'] is List) {
        return data['records'];
      }
      if (data.containsKey('data')) {
        if (data['data'] is List) {
          return data['data'];
        }
        // If it's a single object under 'data', we might want to return it as a single-item list
        // but usually, if a list is expected, 'data' should be a list.
      }
      
      // If the map itself represents the object we want, but we expected a list, 
      // it might be a single object response where we expected multiple.
      // However, usually this is an error in expectation or backend format.
      dev.log("Expected a list but got a Map: $data", name: 'ApiUtils');
    }

    dev.log("Invalid API response format. Expected List or wrapped List, got: ${data.runtimeType}", name: 'ApiUtils');
    return []; // Return empty list instead of crashing, or throw if preferred
  }

  static List<dynamic> extractWrappedList(
    dynamic data, {
    required List<String> keys,
  }) {
    if (data == null) return [];
    if (data is List) return data;

    if (data is Map<String, dynamic>) {
      for (final key in keys) {
        final value = data[key];
        if (value is List) return value;
      }
    }

    dev.log(
      "Invalid wrapped list format. Keys: $keys, got: ${data.runtimeType}",
      name: 'ApiUtils',
    );
    return [];
  }

  static Map<String, dynamic> extractMap(dynamic data) {
    if (data == null) return {};
    
    if (data is Map<String, dynamic>) {
      // If it's already a map, it might be wrapped
      if (data.containsKey('data') && data['data'] is Map<String, dynamic>) {
        return data['data'];
      }
      return data;
    }
    
    if (data is List && data.isNotEmpty) {
      dev.log("Expected a map but got a List. Returning first element.", name: 'ApiUtils');
      if (data[0] is Map<String, dynamic>) {
        return data[0];
      }
    }

    dev.log("Invalid API response format. Expected Map, got: ${data.runtimeType}", name: 'ApiUtils');
    return {};
  }

  static String? readErrorMessage(Object error) {
    try {
      final dynamic e = error;
      final dynamic response = e.response;
      final dynamic body = response?.data;
      if (body is Map<String, dynamic>) {
        final message = body['message'];
        if (message is String && message.isNotEmpty) return message;
        final err = body['error'];
        if (err is String && err.isNotEmpty) return err;
      }
    } catch (_) {}
    return null;
  }
}
