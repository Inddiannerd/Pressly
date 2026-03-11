import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_laundary/core/providers/firebase_providers.dart';
import 'package:smart_laundary/features/profile/presentation/providers/address_providers.dart';
import 'package:smart_laundary/features/profile/domain/entities/address.dart';
import 'package:smart_laundary/features/laundry/presentation/providers/laundry_item_providers.dart';
import 'package:smart_laundary/features/laundry/domain/entities/laundry_item.dart';
import '../../domain/entities/order.dart';
import '../providers/order_providers.dart';
import '../../../../core/widgets/app_drawer.dart';

class CreateOrderScreen extends ConsumerStatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  ConsumerState<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends ConsumerState<CreateOrderScreen> {
  AddressEntity? selectedAddress;

  @override
  void initState() {
    super.initState();
    // Clear items when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderItemsProvider.notifier).clear();
    });
  }

  double _calculateTotal(Map<String, int> orderItems, List<LaundryItemEntity> laundryItems) {
    double total = 0;
    orderItems.forEach((name, quantity) {
      final item = laundryItems.firstWhere((element) => element.name == name, orElse: () => const LaundryItemEntity(id: '', name: '', price: 0));
      if (item.name.isNotEmpty) {
        total += item.price * quantity;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final addressesAsync = ref.watch(userAddressesProvider);
    final createOrderState = ref.watch(createOrderProvider);
    final laundryItemsAsync = ref.watch(laundryItemsProvider);
    final orderItems = ref.watch(orderItemsProvider);
    final theme = Theme.of(context);

    double totalAmount = 0;
    laundryItemsAsync.whenData((items) {
      totalAmount = _calculateTotal(orderItems, items);
    });

    ref.listen(createOrderProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order created successfully!"),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${next.error}"),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Order"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pickup & Delivery Address",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  addressesAsync.when(
                    data: (addresses) {
                      if (addresses.isEmpty) {
                        return _EmptyAddressState(
                          onAdd: () => context.push('/addresses/add'),
                        );
                      }
                      return Column(
                        children: addresses.map((addr) {
                          final isSelected = selectedAddress?.id == addr.id;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () => setState(() => selectedAddress = addr),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.outlineVariant,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  color: isSelected
                                      ? theme.colorScheme.primaryContainer.withOpacity(0.1)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.surfaceContainerHighest,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isSelected ? Icons.check_rounded : Icons.location_on_outlined,
                                        color: isSelected ? Colors.white : theme.colorScheme.onSurfaceVariant,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addr.label,
                                            style: theme.textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? theme.colorScheme.primary : null,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            addr.addressLine1,
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text("Error: $e")),
                  ),
                  const SizedBox(height: 24),
                  const _LaundryItemSelector(),
                  _OrderSummary(totalAmount: totalAmount),
                ],
              ),
            ),
          ),
          _BottomAction(
            isLoading: createOrderState.isLoading,
            isEnabled: selectedAddress != null && totalAmount > 0,
            onPressed: () {
              final user = ref.read(firebaseAuthProvider).currentUser;
              if (user == null) return;

              final order = OrderEntity(
                id: const Uuid().v4(),
                userId: user.uid,
                userEmail: user.email ?? 'N/A',
                addressId: selectedAddress!.id,
                status: OrderStatus.pending,
                createdAt: DateTime.now(),
                totalAmount: totalAmount,
                items: orderItems,
                addressLabel: selectedAddress!.label,
                addressDetails: selectedAddress!.addressLine1,
              );

              ref.read(createOrderProvider.notifier).createOrder(order);
            },
          ),
        ],
      ),
    );
  }
}

class _LaundryItemSelector extends ConsumerWidget {
  const _LaundryItemSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laundryItemsAsync = ref.watch(laundryItemsProvider);
    final orderItems = ref.watch(orderItemsProvider);
    final theme = Theme.of(context);

    return laundryItemsAsync.when(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Items",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) {
              final quantity = orderItems[item.name] ?? 0;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹${item.price.toStringAsFixed(0)} / item",
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(orderItemsProvider.notifier).updateQuantity(item.name, quantity - 1);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(
                          width: 30,
                          child: Text(
                            quantity.toString(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(orderItemsProvider.notifier).updateQuantity(item.name, quantity + 1);
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text("Error loading items: $e", style: TextStyle(color: theme.colorScheme.error)),
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final double totalAmount;

  const _OrderSummary({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _SummaryRow(label: "Items Total", value: "₹${totalAmount.toStringAsFixed(2)}"),
          _SummaryRow(label: "Service Fee", value: "FREE", isFree: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _SummaryRow(
            label: "Total Pay",
            value: "₹${totalAmount.toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isFree;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isFree = false,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                : theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isFree
                  ? Colors.green
                  : isTotal
                      ? theme.colorScheme.primary
                      : null,
              fontSize: isTotal ? 18 : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _BottomAction({
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 54),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Text(
                "Confirm & Pay",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
      ),
    );
  }
}

class _EmptyAddressState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyAddressState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.errorContainer.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.location_off_rounded, color: theme.colorScheme.error, size: 40),
          const SizedBox(height: 16),
          const Text(
            "No addresses found",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Please add an address to continue",
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
            label: const Text("Add Address"),
          ),
        ],
      ),
    );
  }
}
