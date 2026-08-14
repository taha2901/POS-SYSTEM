import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../mock_data/mock_data.dart';
import '../models/draft_branch.dart';

/// حالة شاشة الفروع: الفروع المضافة في الجلسة الحالية.
class BranchesController extends ChangeNotifier {
  final List<DraftBranch> _drafts = <DraftBranch>[];

  UnmodifiableListView<DraftBranch> get drafts =>
      UnmodifiableListView<DraftBranch>(_drafts);

  int get branchesCount => MockData.branches.length + _drafts.length;

  int get openCount => MockData.branches.where((Branch b) => b.isOpen).length;

  double get todayTotal => MockData.branches
      .fold<double>(0, (double s, Branch b) => s + b.todaySales);

  double get monthTotal => MockData.branches
      .fold<double>(0, (double s, Branch b) => s + b.monthSales);

  void addDraft(DraftBranch draft) {
    _drafts.add(draft);
    notifyListeners();
  }
}
