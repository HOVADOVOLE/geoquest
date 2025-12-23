import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'leaderboard_controller.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = ref.watch(leaderboardControllerProvider);
    final dateFormat = DateFormat('d.M.yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Žebříček')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Top Výsledky', style: ShadTheme.of(context).textTheme.h2),
            const SizedBox(height: 20),
            Expanded(
              child: scores.isEmpty
                  ? const Center(
                      child: Text('Zatím žádné výsledky. Zahraj si hru!'),
                    )
                  : ListView.separated(
                      itemCount: scores.length,
                      separatorBuilder: (ctx, index) => const Divider(),
                      itemBuilder: (ctx, index) {
                        final entry = scores[index];
                        final isTop3 = index < 3;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isTop3
                                ? Colors.amber
                                : Colors.grey[300],
                            foregroundColor: isTop3
                                ? Colors.black
                                : Colors.grey[800],
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            'Skóre: ${entry.score} / ${entry.totalQuestions}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(dateFormat.format(entry.date)),
                          trailing: isTop3
                              ? const Icon(Icons.star, color: Colors.amber)
                              : null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
