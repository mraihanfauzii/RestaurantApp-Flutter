import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_detail_provider.dart';

class ReviewForm extends StatefulWidget {
  final String restaurantId;

  const ReviewForm({super.key, required this.restaurantId});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  var _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_nameController.text.isNotEmpty && _reviewController.text.isNotEmpty) {
      setState(() {
        _isSubmitting = true;
      });

      final provider = Provider.of<RestaurantDetailProvider>(context, listen: false);
      await provider.addReview(_nameController.text, _reviewController.text);

      setState(() {
        _isSubmitting = false;
      });

      _nameController.clear();
      _reviewController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tambahkan Review:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextField(
            controller: _reviewController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Review'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submitReview,
            child: _isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
