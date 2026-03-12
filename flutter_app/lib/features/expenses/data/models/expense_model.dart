import '../../domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {

  ExpenseModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.category,
    super.description,
    required super.date,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {

    return ExpenseModel(
      id: json["id"],
      title: json["title"],
      amount: json["amount"].toDouble(),
      category: json["category"],
      description: json["description"],
      date: json["date"],
    );

  }

}