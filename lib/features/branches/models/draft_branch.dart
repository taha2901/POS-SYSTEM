/// فرع مضاف من الحوار (مش موجود في الـMock Data الأصلية).
class DraftBranch {
  const DraftBranch({
    required this.name,
    required this.address,
    required this.manager,
  });

  final String name;
  final String address;
  final String manager;
}
