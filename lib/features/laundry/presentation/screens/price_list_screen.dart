import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/laundry_item.dart';
import '../providers/laundry_item_providers.dart';

class PriceListScreen extends ConsumerWidget {
  const PriceListScreen({super.key});

  void _showItemDialog(BuildContext context, WidgetRef ref, [LaundryItemEntity? item]) {
    final nameController = TextEditingController(text: item?.name ?? '');
    final priceController = TextEditingController(text: item?.price.toString() ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item == null ? 'Add Laundry Item' : 'Edit Laundry Item'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price (₹)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (double.tryParse(v) == null) return 'Invalid price';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final newItem = LaundryItemEntity(
                  id: item?.id ?? const Uuid().v4(),
                  name: nameController.text.trim(),
                  price: double.parse(priceController.text.trim()),
                );

                if (item == null) {
                  await ref.read(laundryItemControllerProvider.notifier).addItem(newItem);
                } else {
                  await ref.read(laundryItemControllerProvider.notifier).updateItem(newItem);
                }
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laundryItemsAsync = ref.watch(laundryItemsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Price List'),
      ),
      body: laundryItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt_rounded, size: 64, color: theme.colorScheme.primary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  const Text('No items in the price list'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _showItemDialog(context, ref),
                    child: const Text('Add First Item'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(
                    '₹${item.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _showItemDialog(context, ref, item),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Item?'),
                        content: Text('Are you sure you want to delete "${item.name}"?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
                          TextButton(
                            onPressed: () async {
                              await ref.read(laundryItemControllerProvider.notifier).deleteItem(item.id);
                              if (context.mounted) Navigator.pop(context);
                            },
                            child: const Text('Yes, Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showItemDialog(context, ref),
        label: const Text('Add Item'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
