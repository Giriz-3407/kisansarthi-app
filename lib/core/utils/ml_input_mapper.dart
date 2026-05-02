class MlInputMapper {
  MlInputMapper._();

  static const Map<String, String> cropSuggestionToFertilizerCrop = {
    'sugarcane': 'sugarcane',
    'sorghum': 'jowar',
    'cotton': 'cotton',
    'rice': 'rice',
    'wheat': 'wheat',
    'groundnut': 'groundnut',
    'maize': 'maize',
    'corn': 'maize',
    'tur': 'tur',
    'redgram': 'tur',
    'blackgram': 'urad',
    'urad': 'urad',
    'greengram': 'moong',
    'moong': 'moong',
    'bengalgram': 'gram',
    'gram': 'gram',
    'masoor': 'masoor',
    'soybean': 'soyabean',
    'soyabean': 'soyabean',
    'ginger': 'ginger',
    'turmeric': 'turmeric',
    'grapes': 'grapes',
    'pearl millet': 'jowar',
    'panivaragu': 'jowar',
    'varagu': 'jowar',
    'samai': 'jowar',
    'thinai': 'jowar',
    'kudiraivali': 'jowar',
    'ragi': 'jowar',
    'bajra': 'jowar',
    'finger millet': 'jowar',
    'little millet': 'jowar',
    'foxtail millet': 'jowar',
    'kodo millet': 'jowar',
    'barnyard millet': 'jowar',
    'proso millet': 'jowar',
  };

  static const Map<String, int> soilColorEncoding = {
    'Red': 0,
    'Black': 1,
    'Sandy': 2,
    'Clay': 3,
    'Loamy': 4,
  };

  static String? normalizeFertilizerCrop(String cropName) {
    return cropSuggestionToFertilizerCrop[cropName.trim().toLowerCase()];
  }

  static int? encodeSoilColor(String? soilColor) {
    if (soilColor == null) return null;
    return soilColorEncoding[soilColor.trim()];
  }
}
