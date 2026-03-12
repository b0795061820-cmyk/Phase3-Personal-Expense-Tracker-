class ExpenseEntity {

  final int id;
  final String title;
  final double amount;
  final String category;
  final String? description;
  final String date;

  ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    this.description,
    required this.date,
  });

}