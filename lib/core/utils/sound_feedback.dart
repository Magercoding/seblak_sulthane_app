import 'package:flutter/services.dart';

class SoundFeedback {
  /// Play tap sound for general button clicks and interactions
  static void playTapSound() {
    HapticFeedback.lightImpact(); // Haptic feedback
    SystemSound.play(SystemSoundType.click); // Sound feedback
  }

  /// Play success sound for successful actions
  static void playSuccessSound() {
    HapticFeedback.mediumImpact();
    SystemSound.play(SystemSoundType.click);
  }

  /// Play selection sound for tab/option selection
  static void playSelectionSound() {
    HapticFeedback.selectionClick();
    SystemSound.play(SystemSoundType.click);
  }
}
