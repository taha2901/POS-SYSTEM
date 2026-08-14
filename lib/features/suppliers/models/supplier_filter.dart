/// فلترة حالة المورد.
enum SupplierFilter { all, active, inactive, due }

extension SupplierFilterInfo on SupplierFilter {
  String get label => switch (this) {
        SupplierFilter.all => 'كل الموردين',
        SupplierFilter.active => 'نشط',
        SupplierFilter.inactive => 'موقوف',
        SupplierFilter.due => 'عليه مستحقات',
      };
}
