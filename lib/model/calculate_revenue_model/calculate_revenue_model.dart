class RevenueData {
  final double totalRevenue;

  RevenueData({
    required this.totalRevenue,
  });

  factory RevenueData.fromJson(Map<String, dynamic> json) {
    return RevenueData(
      totalRevenue: json['total_revenue'] as double,
    );
  }
}
