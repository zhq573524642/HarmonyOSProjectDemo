import { StartupTask,common} from '@kit.AbilityKit';

@Sendable
export default class StartupTask_001 extends StartupTask{
  constructor() {
    super()
  }

   async  init(context: common.AbilityStageContext): Promise<void | Object> {
    return 'StartupTask_001'
  }

  onDependencyCompleted(dependency: string, result: Object): void {
  }
}