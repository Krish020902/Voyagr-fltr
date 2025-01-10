import 'package:Voyagr/data/travel_spots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class CardSwipperWidget extends StatefulWidget {
  const CardSwipperWidget({Key? key}) : super(key: key);

  @override
  _CardSwipperWidgetState createState() => _CardSwipperWidgetState();
}

class _CardSwipperWidgetState extends State<CardSwipperWidget> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return spots.isEmpty
        ? const Center(child: Text('No spots available'))
        : CardSwiper(
            controller: controller,
            cardsCount: spots.length,
            numberOfCardsDisplayed: 2,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
              return _buildTravelCard(spots[index]);
            },
            onSwipe: (previousIndex, currentIndex, direction) {
              return true;
            },
            scale: 0.9,
            padding: const EdgeInsets.all(20),
          );
  }

  Widget _buildTravelCard(TravelSpot spot) {
    return Container(
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
        // crossAxisAlignment: CrossAxisAlignment.end,
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
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
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
                      ],
                    )),
              ],
            ),
          ),
          Padding(
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
                Text(
                  spot.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.star, onPressed: () {}),
                    _buildActionButton(Icons.close,
                        onPressed: () =>
                            controller.swipe(CardSwiperDirection.left)),
                    _buildActionButton(Icons.favorite,
                        onPressed: () =>
                            controller.swipe(CardSwiperDirection.right)),
                    _buildActionButton(Icons.flash_on, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
