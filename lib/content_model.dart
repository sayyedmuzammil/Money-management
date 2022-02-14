class ContentModel {
  String content="item";
  String category="income";
  String amount='0';
  String remark='content remark';
  String date='20-10-2000';
  ContentModel(this.category, this.content, this.amount, this.remark,this.date);
  @override
  String toString() {
    return '{ ${this.category}, ${this.content}, ${this.amount}, ${this.remark},${this.date} }';
  }
}
