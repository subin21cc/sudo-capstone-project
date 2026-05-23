import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/notification/data/repositories/mock_notification_repository.dart';
import 'package:oncare/features/notification/presentation/controllers/notification_controller.dart';

void main() {
  test('notificationListProvider returns the mock repo payload', () async {
    final container = ProviderContainer(
      overrides: <Override>[
        notificationRepositoryProvider.overrideWithValue(
          const MockNotificationRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final list = await container.read(notificationListProvider.future);
    expect(list.length, 4);
    expect(list.first.id, 'a1');
    // Mix of read/unread for the unreadCount badge logic to lean on.
    expect(list.any((e) => !e.read), isTrue);
    expect(list.any((e) => e.read), isTrue);
  });
}
