import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/address.dart';
import '../providers/address_form_provider.dart';

class AddressFormScreen extends ConsumerStatefulWidget {
  final AddressEntity? address;

  const AddressFormScreen({super.key, this.address});

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _labelController;
  late final TextEditingController _addressLine1Controller;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _countryController;
  late final TextEditingController _landmarkController;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _labelController = TextEditingController(text: address?.label ?? '');
    _addressLine1Controller = TextEditingController(text: address?.addressLine1 ?? '');
    _cityController = TextEditingController(text: address?.city ?? '');
    _stateController = TextEditingController(text: address?.state ?? '');
    _zipCodeController = TextEditingController(text: address?.zipCode ?? '');
    _countryController = TextEditingController(text: address?.country ?? '');
    _landmarkController = TextEditingController(text: address?.landmark ?? '');
    _isDefault = address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressLine1Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final isEdit = widget.address != null;
    final address = AddressEntity(
      id: widget.address?.id ?? const Uuid().v4(),
      userId: widget.address?.userId ?? '', 
      label: _labelController.text.trim(),
      addressLine1: _addressLine1Controller.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      zipCode: _zipCodeController.text.trim(),
      country: _countryController.text.trim(),
      landmark: _landmarkController.text.trim().isEmpty ? null : _landmarkController.text.trim(),
      isDefault: _isDefault,
    );

    await ref.read(addressFormProvider.notifier).submitAddress(
      address: address,
      isEdit: isEdit,
    );

    if (mounted && !ref.read(addressFormProvider).hasError) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEdit ? 'Address updated!' : 'Address added!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  InputDecoration _getInputDecoration(String label, IconData icon, ThemeData theme) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressFormProvider);
    final theme = Theme.of(context);

    ref.listen(addressFormProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? 'Add Address' : 'Edit Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address Details",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _labelController,
                decoration: _getInputDecoration('Label (e.g. Home, Office)', Icons.label_outline_rounded, theme),
                validator: (v) => v == null || v.isEmpty ? 'Please enter a label' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressLine1Controller,
                decoration: _getInputDecoration('Street Address', Icons.home_outlined, theme),
                validator: (v) => v == null || v.isEmpty ? 'Please enter street address' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: _getInputDecoration('City', Icons.location_city_rounded, theme),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _zipCodeController,
                      decoration: _getInputDecoration('Zip Code', Icons.pin_drop_outlined, theme),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stateController,
                      decoration: _getInputDecoration('State', Icons.map_outlined, theme),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _countryController,
                      decoration: _getInputDecoration('Country', Icons.public_rounded, theme),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _landmarkController,
                decoration: _getInputDecoration('Landmark (Optional)', Icons.assistant_photo_outlined, theme),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Set as Default Address'),
                subtitle: const Text('Use this for quick checkouts'),
                value: _isDefault,
                onChanged: (v) => setState(() => _isDefault = v),
                contentPadding: EdgeInsets.zero,
                activeColor: theme.colorScheme.primary,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: state.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                ),
                child: state.isLoading 
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      widget.address == null ? 'Save Address' : 'Update Address',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
