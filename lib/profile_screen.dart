import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'common_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '프로필'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    debugPrint('프로필 수정 버튼을 눌렀습니다.');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.violet,
                    side: const BorderSide(color: AppColors.violet),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/person.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.violet,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: const Text('프로필 수정'),
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatItem(label: '본 영화', value: '24'),
                  SizedBox(width: 16),
                  StatItem(label: '평균 평점', value: '4.5'),
                  SizedBox(width: 16),
                  StatItem(label: '즐겨찾기', value: '8'),
                ],
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('선호하는 장르', style: AppTextStyles.titleMedium),
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.centerLeft,
                child: FavoriteGenres(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
            'assets/images/profile/profile_movielog.jpg',
          ),
        ),
        const SizedBox(height: 12),
        const Text('무비러버', style: AppTextStyles.titleLarge),
        const SizedBox(height: 4),
        const Text(
          '좋아하는 영화를 기록하고 있어요',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.violet),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(color: AppColors.violet),
          ),
        ],
      ),
    );
  }
}

class FavoriteGenres extends StatelessWidget {
  const FavoriteGenres({super.key});

  static const List<Map<String, dynamic>> genres = [
    {'label': '드라마', 'icon': Icons.theater_comedy_outlined},
    {'label': 'SF', 'icon': Icons.rocket_launch_outlined},
    {'label': '애니메이션', 'icon': Icons.animation_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) {
        return Chip(
          avatar: Icon(
            genre['icon'] as IconData,
            size: 18,
            color: AppColors.violet,
          ),
          label: Text(genre['label'] as String, style: AppTextStyles.bodySmall),
          backgroundColor: AppColors.violet.withValues(alpha: 0.12),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }
}
