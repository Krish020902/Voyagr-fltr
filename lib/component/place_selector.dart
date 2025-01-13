import 'package:Voyagr/data/places.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PlaceContainer extends GetxController {
  final GetStorage storage = GetStorage();
  var selectedPlaces = <dynamic>[].obs;

  PlaceContainer() {
    final savedPlaces = storage.read<List<dynamic>>('places');
    if (savedPlaces != null) {
      selectedPlaces.addAll(savedPlaces);
    }
  }

  void togglePlace(String place) {
    if (selectedPlaces.contains(place)) {
      selectedPlaces.remove(place);
    } else {
      selectedPlaces.add(place);
    }
    // onPlacesSelected(selectedPlaces);
    storage.write('places', selectedPlaces);
  }
}

class PlaceSelector extends StatelessWidget {
  final PlaceContainer placeContainer = Get.put(PlaceContainer());

  PlaceSelector({
    super.key,
  });

  void _showPlacesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Select Places',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return Obx(() => _buildPlaceChip(
                        places[index]['name'],
                        places[index]['icon'],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceChip(String place, IconData icon) {
    final isSelected = placeContainer.selectedPlaces.contains(place);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => placeContainer.togglePlace(place), // Pass callback
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.teal.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.teal : Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.teal : Colors.grey,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  place,
                  style: TextStyle(
                    color: isSelected ? Colors.teal : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPlacesBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              String displayText;
              if (placeContainer.selectedPlaces.isEmpty) {
                displayText = 'Select Preferred Places';
              } else if (placeContainer.selectedPlaces.length <= 2) {
                displayText = placeContainer.selectedPlaces.join(', ');
              } else {
                displayText =
                    '${placeContainer.selectedPlaces[0]}, ${placeContainer.selectedPlaces[1]}, ...';
              }
              return Text(
                displayText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              );
            }),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
