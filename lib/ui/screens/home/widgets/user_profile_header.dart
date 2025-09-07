import 'package:connectinno_case_client/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectinno_case_client/domain/repositories/auth/auth_repository.dart';
import 'package:connectinno_case_client/core/theme/app_colors.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = context.read<AuthRepository>();
    final currentUser = authRepo.currentUser;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        children: [
          // Profile Picture
          _UserAvatar(currentUser: currentUser),

          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: _UserInfo(currentUser: currentUser),
          ),

          // Sign Out Button
          _SignOutButton(authRepo: authRepo),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    required this.authRepo,
  });

  final AuthRepository authRepo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        try {
          await authRepo.signOut();
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to sign out.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.logout,
          color: AppColors.secondaryText,
          size: 24,
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    required this.currentUser,
  });

  final UserEntity? currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentUser?.displayName ?? 'User',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        if (currentUser?.email != null) ...[
          const SizedBox(height: 2),
          Text(
            currentUser!.email,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.currentUser,
  });

  final UserEntity? currentUser;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: currentUser?.photoUrl != null
          ? NetworkImage(currentUser!.photoUrl!)
          : null,
      child: currentUser?.photoUrl == null
          ? Icon(Icons.person, color: Colors.grey.shade600, size: 28)
          : null,
    );
  }
}
