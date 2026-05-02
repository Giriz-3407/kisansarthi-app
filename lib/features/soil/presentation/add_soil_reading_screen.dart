import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/features/soil/domain/soil_repository.dart';
import 'package:kisansarthi/features/weather/presentation/weather_notifier.dart';

class AddSoilReadingScreen extends ConsumerStatefulWidget {
  final int landId;
  const AddSoilReadingScreen({super.key, required this.landId});

  @override
  ConsumerState<AddSoilReadingScreen> createState() => _AddSoilReadingScreenState();
}

class _AddSoilReadingScreenState extends ConsumerState<AddSoilReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nController = TextEditingController();
  final _pController = TextEditingController();
  final _kController = TextEditingController();
  final _phController = TextEditingController();
  final _rainfallController = TextEditingController();
  final _tempController = TextEditingController();
  final _humidityController = TextEditingController();
  bool _isLoading = false;
  bool _isLocationLoading = false;

  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _phController.dispose();
    _rainfallController.dispose();
    _tempController.dispose();
    _humidityController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocationAndData() async {
    setState(() => _isLocationLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      final position = await Geolocator.getCurrentPosition();
      final weatherData = await ref.read(weatherProvider((lat: position.latitude, lon: position.longitude)).future);

      if (weatherData.containsKey('temperature')) {
        _tempController.text = weatherData['temperature'].toString();
      }
      if (weatherData.containsKey('humidity')) {
        _humidityController.text = weatherData['humidity'].toString();
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Auto-filled temperature and humidity from location.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch location data: $e. You can enter manually.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLocationLoading = false);
    }
  }

  double? parseValue(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final repository = ref.read(soilRepositoryProvider);
        
        // 1. Extract ALL values BEFORE API call
        final N = parseValue(_nController);
        final P = parseValue(_pController);
        final K = parseValue(_kController);
        final ph = parseValue(_phController);
        final rainfall = parseValue(_rainfallController);
        final temperature = parseValue(_tempController);
        final humidity = parseValue(_humidityController);

        // 2. VALIDATE before sending
        if (N == null ||
            P == null ||
            K == null ||
            ph == null ||
            rainfall == null ||
            temperature == null ||
            humidity == null) {
          throw Exception("All fields must be filled correctly");
        }

        // 3. Build request body ONLY using parsed values
        final body = {
          "N": N,
          "P": P,
          "K": K,
          "ph": ph,
          "rainfall": rainfall,
          "temperature": temperature,
          "humidity": humidity,
        };

        // 4. DEBUG print before sending
        print("FINAL BODY: $body");

        await repository.addManualSoilReading(widget.landId, body);
        ref.invalidate(landSoilReadingsProvider(widget.landId));
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding reading: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Soil Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_isLocationLoading)
                const Center(child: Padding(padding: EdgeInsets.only(bottom: 16), child: CircularProgressIndicator()))
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton.icon(
                    onPressed: _fetchLocationAndData,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Use Current Location'),
                  ),
                ),
              _buildNumericField(_nController, 'Nitrogen (N)'),
              _buildNumericField(_pController, 'Phosphorus (P)'),
              _buildNumericField(_kController, 'Potassium (K)'),
              _buildNumericField(_phController, 'pH Level', min: 0, max: 14),
              _buildNumericField(_rainfallController, 'Rainfall (mm)'),
              _buildNumericField(_tempController, 'Temperature (°C)'),
              _buildNumericField(_humidityController, 'Humidity (%)', min: 0, max: 100),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Reading'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumericField(
    TextEditingController controller,
    String label, {
    double? min,
    double? max,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final numValue = double.tryParse(value);
        if (numValue == null) return 'Invalid number';
        if (min != null && numValue < min) return 'Must be >= $min';
        if (max != null && numValue > max) return 'Must be <= $max';
        return null;
      },
    );
  }
}
