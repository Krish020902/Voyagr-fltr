final List<TravelSpot> spots = [
  TravelSpot(
    imageAsset: 'assets/icons/01.jpg',
    location: 'Taj Mahal, Agra',
    priceRange: '₹6,000 - ₹12,000',
    description:
        'Full-time Traveller. Globe Trotter. Occasional Photographer. Part-time Singer/Dancer.',
    matchPercentage: 67,
  ),
  TravelSpot(
    imageAsset: 'assets/icons/03.jpg',
    location: 'Hampi, Karnataka',
    priceRange: '₹8,000 - ₹15,000',
    description: 'Adventure Seeker. Cultural Explorer. Food Enthusiast.',
    matchPercentage: 82,
  ),
  TravelSpot(
    imageAsset: 'assets/icons/02.jpg',
    location: 'Goa, Maharashtra',
    priceRange: '₹10,000 - ₹20,000',
    description: 'Beach Lover. Sunset Chaser. Party Animal.',
    matchPercentage: 75,
  ),
];

class TravelSpot {
  final String imageAsset;
  final String location;
  final String priceRange;
  final String description;
  final int matchPercentage;

  TravelSpot({
    required this.imageAsset,
    required this.location,
    required this.priceRange,
    required this.description,
    required this.matchPercentage,
  });
}
