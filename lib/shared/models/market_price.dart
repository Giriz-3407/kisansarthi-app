class MarketPrice {
  final String arrivalDate;
  final String commodity;
  final String district;
  final String market;
  final double maxPrice;
  final double minPrice;
  final double modalPrice;
  final String state;
  final String variety;

  MarketPrice({
    required this.arrivalDate,
    required this.commodity,
    required this.district,
    required this.market,
    required this.maxPrice,
    required this.minPrice,
    required this.modalPrice,
    required this.state,
    required this.variety,
  });

  factory MarketPrice.fromJson(Map<String, dynamic> json) {
    return MarketPrice(
      arrivalDate: json['Arrival_Date']?.toString() ?? '',
      commodity: json['Commodity']?.toString() ?? '',
      district: json['District']?.toString() ?? '',
      market: json['Market']?.toString() ?? '',
      maxPrice: double.tryParse(json['Max_Price']?.toString() ?? '0') ?? 0.0,
      minPrice: double.tryParse(json['Min_Price']?.toString() ?? '0') ?? 0.0,
      modalPrice: double.tryParse(json['Modal_Price']?.toString() ?? '0') ?? 0.0,
      state: json['State']?.toString() ?? '',
      variety: json['Variety']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Arrival_Date': arrivalDate,
      'Commodity': commodity,
      'District': district,
      'Market': market,
      'Max_Price': maxPrice,
      'Min_Price': minPrice,
      'Modal_Price': modalPrice,
      'State': state,
      'Variety': variety,
    };
  }
}
