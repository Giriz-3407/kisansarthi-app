import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/plantings/data/planting_repository_impl.dart';
import 'package:kisansarthi/features/plantings/domain/planting_repository.dart';

final plantingRepositoryProvider = Provider<PlantingRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PlantingRepositoryImpl(dio);
});

class AddPlantingScreen extends ConsumerStatefulWidget {
  final int landId;
  final String? initialCropName;
  const AddPlantingScreen({super.key, required this.landId, this.initialCropName});

  @override
  ConsumerState<AddPlantingScreen> createState() => _AddPlantingScreenState();
}

class _AddPlantingScreenState extends ConsumerState<AddPlantingScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cropController;
  final _dateController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cropController = TextEditingController(text: widget.initialCropName);
    _dateController.text = DateTime.now().toIso8601String().split('T')[0];
  }

  @override
  void dispose() {
    _cropController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final repo = ref.read(plantingRepositoryProvider);
        await repo.createPlanting(
          widget.landId,
          _cropController.text,
          plantingDate: _dateController.text,
        );
        await ref.read(landCropProvider(widget.landId).notifier).selectCrop(
              name: _cropController.text,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Planting started successfully!')),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          final errorMsg = e.toString().toLowerCase();
          String displayMsg = 'Error: $e';
          if (errorMsg.contains('409') || errorMsg.contains('conflict')) {
            displayMsg = 'A crop is already selected and active for this land. Please complete or cancel it before starting a new one.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(displayMsg)),
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
      appBar: AppBar(title: const Text('Start New Planting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cropController,
                decoration: const InputDecoration(labelText: 'Crop Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Planting Date (YYYY-MM-DD)'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Confirm Planting'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
