import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_notifier.dart';

class AddLandScreen extends ConsumerStatefulWidget {
  final int farmId;
  const AddLandScreen({super.key, required this.farmId});

  @override
  ConsumerState<AddLandScreen> createState() => _AddLandScreenState();
}

class _AddLandScreenState extends ConsumerState<AddLandScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();
  final _unitController = TextEditingController(text: 'acres');
  String? _selectedLandType;
  bool _isLoading = false;

  final List<String> _landTypes = [
    'Alluvial soil',
    'Black Soil',
    'Clay soil',
    'Laterite soil',
    'Loamy soil',
    'Red soil',
    'Sandy soil'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final repository = ref.read(landRepositoryProvider);
        await repository.createLand(
          widget.farmId,
          _nameController.text.trim(),
          landType: _selectedLandType,
          area: double.tryParse(_areaController.text.trim()),
          areaUnit: _unitController.text.trim().toLowerCase(),
        );
        ref.invalidate(farmLandsProvider(widget.farmId));
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding land: $e')),
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
      appBar: AppBar(title: const Text('Add Land')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Land Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedLandType,
                decoration: const InputDecoration(labelText: 'Land Type'),
                items: _landTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLandType = value;
                  });
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _areaController,
                      decoration: const InputDecoration(labelText: 'Area'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Required';
                        final parsed = double.tryParse(value.trim());
                        if (parsed == null || parsed <= 0) return 'Enter a valid positive number';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _unitController,
                      decoration: const InputDecoration(labelText: 'Unit'),
                      validator: (value) {
                        final unit = (value ?? '').trim().toLowerCase();
                        const allowed = {'hectares', 'acres', 'sq_meters'};
                        if (!allowed.contains(unit)) {
                          return 'Use hectares, acres, or sq_meters';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Add Land'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
