class MainScienceBranch {
  int mainScienceBranchId;
  String mainScienceBranchName;

  MainScienceBranch(this.mainScienceBranchId, this.mainScienceBranchName);

  MainScienceBranch.fromJson(Map json)
      : mainScienceBranchId= int.tryParse(json["mainScienceBranchId"].toString())!,
        mainScienceBranchName = json["mainScienceBranchName"];

  Map toJson() {
    return {
      "mainScienceBranchId": mainScienceBranchId,
      "mainScienceBranchName": mainScienceBranchName
    };
  }
}
