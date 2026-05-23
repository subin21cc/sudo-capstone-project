import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/notification/domain/entities/alert_item.dart';

void main() {
  const item = AlertItem(
    id: 'a',
    title: 't',
    body: 'b',
    timeAgo: 'now',
    category: AlertCategory.reminder,
  );

  test('copyWith(read: true) flips only the read flag', () {
    final updated = item.copyWith(read: true);
    expect(updated.read, isTrue);
    expect(updated.id, item.id);
    expect(updated.title, item.title);
    expect(updated.body, item.body);
    expect(updated.category, item.category);
  });

  test('NotificationState.unreadCount counts only unread', () {
    final state = NotificationState(
      items: <AlertItem>[
        item,
        item.copyWith(read: true),
        item.copyWith(read: true),
      ],
    );
    expect(state.unreadCount, 1);
  });
}
