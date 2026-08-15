import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';
import '../controllers/sales_session_controller.dart';
import '../models/held_invoice.dart';
import 'held_invoice_tile.dart';

/// يفتح قائمة الفواتير المعلّقة عشان الكاشير يرجّع أي واحدة.
Future<void> showHeldInvoicesDialog(BuildContext context) {
  final SalesSessionController session =
      context.read<SalesSessionController>();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) =>
        ChangeNotifierProvider<SalesSessionController>.value(
      value: session,
      child: const HeldInvoicesDialog(),
    ),
  );
}

class HeldInvoicesDialog extends StatelessWidget {
  const HeldInvoicesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesSessionController session =
        context.watch<SalesSessionController>();
    final List<HeldInvoice> held = session.held;

    return Dialog(
      child: SizedBox(
        width: 620,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.warningSoft,
                      borderRadius: AppRadius.mdAll,
                    ),
                    child: const Icon(
                      Icons.pause_circle_outline_rounded,
                      size: 20,
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'الفواتير المعلّقة',
                          style: AppText.sectionTitle,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${Fmt.count(held.length)} فاتورة مستنية',
                          style: AppText.caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 360),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (final HeldInvoice inv in held)
                        HeldInvoiceTile(
                          invoice: inv,
                          onRestore: () {
                            session.restore(inv);
                            Navigator.of(context).pop();
                          },
                          onDelete: () => session.deleteHeld(inv),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
