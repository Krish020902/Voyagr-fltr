final List<TravelSpot> spots = [
  TravelSpot(
    imageAsset: 'assets/icons/01.jpg',
    location: 'Taj Mahal, Agra',
    priceRange: '₹6,000 - ₹12,000',
    description:
        'Full-time Traveller. Globe Trotter. Occasional Photographer. Part-time Singer/Dancer.',
    matchPercentage: 67,
    locationType: 'Monument',
    bestFor: 'History Buffs, Architecture Enthusiasts',
    bestTime: 'Sunrise, Sunset',
    highlights: 'UNESCO World Heritage Site, Mughal Architecture',
  ),
  TravelSpot(
    imageAsset: 'assets/icons/03.jpg',
    location: 'Hampi, Karnataka',
    priceRange: '₹8,000 - ₹15,000',
    description: 'Adventure Seeker. Cultural Explorer. Food Enthusiast.',
    matchPercentage: 82,
    locationType: 'Monument2',
    bestFor: 'History Buffs, Architecture Enthusiasts',
    bestTime: 'Sunrise, Sunset',
    highlights: 'UNESCO World Heritage Site, Mughal Architecture',
  ),
  TravelSpot(
    imageAsset: 'assets/icons/02.jpg',
    location: 'Goa',
    priceRange: '₹10,000 - ₹20,000',
    description: 'Beach Lover. Sunset Chaser. Party Animal.',
    matchPercentage: 75,
    locationType: 'Monument3',
    bestFor: 'History Buffs, Architecture Enthusiasts',
    bestTime: 'Sunrise, Sunset',
    highlights: 'UNESCO World Heritage Site, Mughal Architecture',
  ),
];

class TravelSpot {
  final String imageAsset;
  final String location;
  final String priceRange;
  final String description;
  final int matchPercentage;
  final String locationType;
  final String bestFor;
  final String bestTime;
  final String highlights;

  TravelSpot(
      {required this.imageAsset,
      required this.location,
      required this.priceRange,
      required this.description,
      required this.matchPercentage,
      required this.locationType,
      required this.bestFor,
      required this.bestTime,
      required this.highlights});
}
