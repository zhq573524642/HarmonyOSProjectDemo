import ThingModel from "../model/ThingModel";

@Observed
export default class ThingsViewModel {
  @Track thingsName: string = ""
  @Track isFinished: boolean = false;

  updateTask(thingsModel: ThingModel) {
    this.thingsName = thingsModel.thingsName;
    this.isFinished = thingsModel.isFinished;
  }

  updateIsFinished(){
    this.isFinished=!this.isFinished;
  }

  addSuffixes(){
    this.thingsName+="1";
  }
}