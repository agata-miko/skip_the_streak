import 'package:flutter/material.dart';

class MilestoneCarousel extends StatefulWidget {
  @override
  _MilestoneCarouselState createState() => _MilestoneCarouselState();
}

class _MilestoneCarouselState extends State<MilestoneCarousel> {
  int _selectedIndex = 0; // Track the selected item index

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Adjusted height of the carousel container
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            itemExtent: 40, // Adjusted height of each item
            diameterRatio: 2,
            perspective: 0.01,
            physics: FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                _selectedIndex = index; // Update the selected item index
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index >= 0 && index < 100) {
                  return Center(
                    child: Text(
                      '${(index + 1)}', // Milestone values
                      style: TextStyle(
                        fontSize: _selectedIndex == index ? 24 : 18, // Adjusted font sizes
                        fontWeight: _selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _selectedIndex == index
                            ? Colors.blue // Different color for the selected item
                            : Colors.grey,
                      ),
                    ),
                  );
                } else {
                  return null; // Stops creating more items after 100 milestones
                }
              },
            ),
          ),
          // Top divider line
          Positioned(
            top: 50, // Slight space from the selected number
            left: MediaQuery.of(context).size.width * 0.4, // Adjusted left position
            right: MediaQuery.of(context).size.width * 0.4, // Adjusted right position
            child: Divider(
              color: Colors.blueAccent.withOpacity(0.6),
              thickness: 1.5,
              // Adjusted width for a shorter divider
              indent: 20,  // Space from the left
              endIndent: 20, // Space from the right
            ),
          ),

          // Bottom divider line
          Positioned(
            bottom: 50, // Slight space from the selected number
            left: MediaQuery.of(context).size.width * 0.4, // Adjusted left position
            right: MediaQuery.of(context).size.width * 0.4, // Adjusted right position
            child: Divider(
              color: Colors.blueAccent.withOpacity(0.6),
              thickness: 1.5,
              // Adjusted width for a shorter divider
              indent: 20,  // Space from the left
              endIndent: 20, // Space from the right
            ),
          ),
        ],
      ),
    );
  }
}
