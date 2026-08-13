import 'package:flutter/material.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

import '../widgets/trip_details_body.dart';
import '../widgets/trip_details_sliver_app_bar.dart';
import '../widgets/trip_details_sticky_footer.dart';

class TripDetailsPage extends StatefulWidget {
  final TripModel trip;

  const TripDetailsPage({super.key, required this.trip});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 200 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: TripDetailsStickyFooter(trip: widget.trip),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          TripDetailsSliverAppBar(trip: widget.trip, isScrolled: _isScrolled),
          SliverToBoxAdapter(
            child: TripDetailsBody(
              trip: widget.trip,
              selectedTabIndex: _selectedTabIndex,
              onTabSelected: (index) =>
                  setState(() => _selectedTabIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}
