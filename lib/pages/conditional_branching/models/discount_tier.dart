/// Enum representing discount tiers based on purchase amount
enum DiscountTier {
  tier1, // < 500000, 0%
  tier2, // 500000-999999, 10%
  tier3, // 1000000-1499999, 20%
  tier4, // >= 1500000, 30%
}

/// Extension to provide discount rate and minimum amount for each tier
extension DiscountTierExtension on DiscountTier {
  /// Returns the discount rate for this tier
  double get rate {
    switch (this) {
      case DiscountTier.tier1:
        return 0.0;
      case DiscountTier.tier2:
        return 0.10;
      case DiscountTier.tier3:
        return 0.20;
      case DiscountTier.tier4:
        return 0.30;
    }
  }

  /// Returns the minimum purchase amount for this tier
  double get minAmount {
    switch (this) {
      case DiscountTier.tier1:
        return 0;
      case DiscountTier.tier2:
        return 500000;
      case DiscountTier.tier3:
        return 1000000;
      case DiscountTier.tier4:
        return 1500000;
    }
  }
}
