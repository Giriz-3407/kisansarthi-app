class MockApi {
  static dynamic getResponse(String path, {Map<String, dynamic>? queryParameters}) {
    // Auth
    if (path.contains('/auth/login') || path.contains('/auth/register')) {
      return {
        "token": "mock-token",
        "user": {
          "id": 1,
          "name": "Demo Farmer",
          "phone_number": "9876543210",
          "email": "demo@kisan.com"
        }
      };
    }
    if (path.contains('/users/me')) {
      return {
        "id": 1,
        "name": "Demo Farmer",
        "phone_number": "9876543210",
        "email": "demo@kisan.com"
      };
    }

    // Farms
    if (path == '/farms') {
      return [
        {
          "id": 1,
          "name": "Shanti Sadan Farm",
          "location": "Pune, MH",
          "address": "Haveli, Pune",
          "image_path": "https://images.unsplash.com/photo-1500382017468-9049fee74a62",
          "created_at": "2024-01-01T10:00:00Z"
        },
        {
          "id": 2,
          "name": "Ganga Organic Farm",
          "location": "Nashik, MH",
          "address": "Trimbak Road",
          "image_path": "https://images.unsplash.com/photo-1523348837708-15d4a09cfac2",
          "created_at": "2024-01-05T10:00:00Z"
        }
      ];
    }
    if (path.startsWith('/farms/') && !path.contains('/lands') && !path.contains('/hardware_devices')) {
      return {
        "id": 1,
        "name": "Shanti Sadan Farm",
        "location": "Pune, MH",
        "address": "Haveli, Pune",
        "image_path": "https://images.unsplash.com/photo-1500382017468-9049fee74a62",
        "created_at": "2024-01-01T10:00:00Z"
      };
    }

    // Lands
    if (path.contains('/lands') && !path.contains('/soil-readings') && !path.contains('/manual-soil-reading')) {
      if (path.contains('/farms/')) {
         return [
          {"id": 1, "farm_id": 1, "name": "North Field", "land_type": "Black Soil", "area": 2.5, "area_unit": "Acres"},
          {"id": 2, "farm_id": 1, "name": "South Field", "land_type": "Sandy", "area": 1.2, "area_unit": "Acres"}
        ];
      }
      return {"id": 1, "farm_id": 1, "name": "North Field", "land_type": "Black Soil", "area": 2.5, "area_unit": "Acres"};
    }

    // Soil Readings
    if (path.contains('/soil-readings')) {
      return List.generate(10, (index) => {
        "id": index,
        "land_id": 1,
        "nitrogen": 45.0 + index,
        "phosphorus": 30.0 + index,
        "potassium": 25.0 + index,
        "ph": 6.5,
        "rainfall": 100.0 + (index * 10),
        "temperature": 28.0,
        "humidity": 65.0,
        "reading_type": "manual",
        "created_at": DateTime.now().subtract(Duration(days: index)).toIso8601String()
      });
    }

    // Crop Suggestions
    if (path.contains('/crop-suggestions')) {
      return [
        {"crop_name": "Wheat", "match": 0.92, "reason": "Ideal pH and Nitrogen levels", "explanation": "Wheat grows best in loamy soil with high nitrogen.", "expected_yield": "15-20 quintals/acre"},
        {"crop_name": "Mustard", "match": 0.85, "reason": "Suitable temperature", "explanation": "Requires cool climate during growth.", "expected_yield": "10-12 quintals/acre"}
      ];
    }

    // Fertilizer Recommendations
    if (path.contains('/fertilizer-recommendations')) {
      return [
        {"fertilizer_name": "Urea", "dosage": "50kg/acre", "explanation": "To boost nitrogen levels.", "advisory": "Apply during early growth stage."},
        {"fertilizer_name": "DAP", "dosage": "30kg/acre", "explanation": "Phosphorus deficiency noted.", "advisory": "Mix well with soil before sowing."}
      ];
    }

    // Diagnostics
    if (path.contains('/diagnostics/scan-plant')) {
      return {"log_id": 123};
    }
    if (path.contains('/diagnostics/logs/')) {
      return {
        "id": 123,
        "status": "completed",
        "disease_name": "Tomato Late Blight",
        "confidence": 0.98,
        "image_path": "https://images.unsplash.com/photo-1592419044706-39796d40f98c",
        "symptoms": "Dark, water-soaked spots on leaves.",
        "remedies": ["Use copper-based fungicides", "Remove infected plants", "Improve air circulation"],
        "prevention": "Rotate crops and avoid overhead watering.",
        "created_at": DateTime.now().toIso8601String()
      };
    }
    if (path.contains('/diagnostics/logs')) {
      return [
        {
          "id": 123,
          "status": "completed",
          "disease_name": "Tomato Late Blight",
          "confidence": 0.98,
          "created_at": DateTime.now().toIso8601String()
        }
      ];
    }

    // Market
    if (path.contains('/market/prices')) {
      return [
        {"crop": "Rice", "location": "Pune Market", "price": 2500, "currency": "INR"},
        {"crop": "Rice", "location": "Mumbai Market", "price": 2650, "currency": "INR"}
      ];
    }

    // Weather
    if (path.contains('/weather')) {
      return {
        "name": "Pune",
        "temp": 32.5,
        "description": "Sunny",
        "humidity": 45,
        "wind_speed": 12.0
      };
    }

    return {};
  }
}
