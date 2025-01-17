import 'package:Voyagr/data/travel_spots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class CardSwipperWidget extends StatefulWidget {
  const CardSwipperWidget({super.key});

  @override
  _CardSwipperWidgetState createState() => _CardSwipperWidgetState();
}

class _CardSwipperWidgetState extends State<CardSwipperWidget> {
  final CardSwiperController controller = CardSwiperController();
  int? expandedCardIndex;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleSwipeDirection(CardSwiperDirection direction, int previousIndex) {
    switch (direction) {
      case CardSwiperDirection.left:
        print('Swiped left');
        break;
      case CardSwiperDirection.right:
        print('Swiped right');
        // print(spots[previousIndex].location);
        // print(spots[previousIndex].priceRange);
        // print(spots[previousIndex].description);
        break;
      default:
        print('Unknown swipe direction');
    }
  }

  void _toggleCardExpansion(int index) {
    setState(() {
      if (expandedCardIndex == index) {
        expandedCardIndex = null;
      } else {
        expandedCardIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return spots.isEmpty
        ? const Center(child: Text('No spots available'))
        : Stack(
            children: [
              CardSwiper(
                controller: controller,
                cardsCount: spots.length,
                numberOfCardsDisplayed: 2,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  return Stack(
                    children: [
                      _buildTravelCard(spots[index], index),
                      // Base card
                      _buildTravelCard(spots[index], index),
                      // Full card color overlay
                      if (percentThresholdX != 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: percentThresholdX > 0
                                  ? Colors.teal.withOpacity(
                                      (percentThresholdX * 0.15)
                                          .clamp(0.0, 0.15))
                                  : Colors.red.withOpacity(
                                      (percentThresholdX.abs() * 0.15)
                                          .clamp(0.0, 0.15)),
                            ),
                          ),
                        ),
                      // Left swipe overlay
                      if (percentThresholdX < 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.blueGrey.withOpacity(
                                      (percentThresholdX.abs() * 0.5)
                                          .clamp(0.0, 0.5)),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Avoid",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Right swipe overlay
                      if (percentThresholdX > 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.teal.withOpacity(
                                      (percentThresholdX * 0.5)
                                          .clamp(0.0, 0.5)),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Accompany',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                onSwipe: (previousIndex, currentIndex, direction) {
                  _handleSwipeDirection(direction, previousIndex);
                  if (expandedCardIndex == previousIndex) {
                    setState(() {
                      expandedCardIndex = null;
                    });
                  }
                  return true;
                },
                scale: 0.9,
                padding: const EdgeInsets.all(20),
                allowedSwipeDirection: AllowedSwipeDirection.only(
                  left: true,
                  right: true,
                ),
              ),
            ],
          );
  }

  Widget _buildTravelCard(TravelSpot spot, int index) {
    bool isExpanded = expandedCardIndex == index;

    return GestureDetector(
      onTap: () => _toggleCardExpansion(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      spot.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 116,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${spot.matchPercentage}% Match!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      spot.location,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      spot.priceRange,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedCrossFade(
                      firstChild: Text(
                        spot.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot.description,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildExpandedDetails(spot),
                        ],
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(Icons.star, onPressed: () {}),
                        _buildActionButton(
                          Icons.close,
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.left),
                        ),
                        _buildActionButton(
                          Icons.favorite,
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.right),
                        ),
                        _buildActionButton(Icons.flash_on, onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedDetails(TravelSpot spot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            Icons.person, 'Gender & Age', '${spot.gender}, ${spot.age}'),
        const SizedBox(height: 8),
        _buildDetailRow(Icons.groups, 'Travel Interest', spot.travelInterest),
        const SizedBox(height: 8),
        _buildDetailRow(Icons.restaurant_menu, 'Diet', spot.diet),
        const SizedBox(height: 8),
        _buildDetailRow(Icons.local_activity, 'Preferred Activities',
            spot.preferredActivities),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, {required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.grey[600],
      ),
    );
  }
}
