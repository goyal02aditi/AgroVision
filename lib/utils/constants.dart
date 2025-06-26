class Constants {
  // Indian states list
  static const List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  // Crop types
  static const Map<String, List<String>> cropsByState = {
    'Punjab': ['Wheat', 'Rice', 'Cotton', 'Sugarcane', 'Maize'],
    'Maharashtra': ['Cotton', 'Sugarcane', 'Rice', 'Wheat', 'Soybean'],
    'Uttar Pradesh': ['Wheat', 'Rice', 'Sugarcane', 'Potato', 'Barley'],
    'Haryana': ['Wheat', 'Rice', 'Cotton', 'Sugarcane', 'Mustard'],
    'Gujarat': ['Cotton', 'Groundnut', 'Wheat', 'Rice', 'Sugarcane'],
    'Karnataka': ['Rice', 'Cotton', 'Sugarcane', 'Ragi', 'Maize'],
    'Andhra Pradesh': ['Rice', 'Cotton', 'Sugarcane', 'Groundnut', 'Chilli'],
    'Tamil Nadu': ['Rice', 'Cotton', 'Sugarcane', 'Groundnut', 'Maize'],
  };

  // Default crops for other states
  static const List<String> defaultCrops = [
    'Rice', 'Wheat', 'Cotton', 'Sugarcane', 'Maize', 'Barley', 'Jowar', 'Bajra'
  ];
}
