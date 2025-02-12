import 'package:flutter/material.dart';
import 'package:lemmy_api_client/v2.dart';

import '../util/extensions/api.dart';
import '../util/goto.dart';
import '../widgets/avatar.dart';
import '../widgets/markdown_text.dart';

/// Infinite list of Users fetched by the given fetcher
class UsersListPage extends StatelessWidget {
  final String title;
  final List<UserViewSafe> users;

  const UsersListPage({Key key, @required this.users, this.title})
      : assert(users != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: change to infinite scroll
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: Text(title ?? ''),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) => UsersListItem(user: users[i]),
        itemCount: users.length,
      ),
    );
  }
}

class UsersListItem extends StatelessWidget {
  final UserViewSafe user;

  const UsersListItem({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(user.user.originDisplayName),
        subtitle: user.user.bio != null
            ? Opacity(
                opacity: 0.5,
                child: MarkdownText(
                  user.user.bio,
                  instanceHost: user.instanceHost,
                ),
              )
            : null,
        onTap: () => goToUser.fromUserSafe(context, user.user),
        leading: Avatar(url: user.user.avatar),
      );
}
