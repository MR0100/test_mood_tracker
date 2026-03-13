part of '../widgets.dart';

class CorePrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CorePrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      height: 50,
      minWidth: 150,
      child: Text(
        title,
        style: AppTextStyles.button.copyWith(color: AppColors.white),
      ),
    );
  }
}
