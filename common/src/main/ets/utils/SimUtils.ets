import { sim } from "@kit.TelephonyKit";

export class SimUtils {
  private static _instance: SimUtils;

  public static getInstance(): SimUtils {
    if (!SimUtils._instance) {
      SimUtils._instance = new SimUtils();
    }
    return SimUtils._instance;
  }

  async isSimActive() {
    if (canIUse("SystemCapability.Telephony.CoreService")) {
      let p = await sim.isSimActive(0)
    } else {
      // Fallback for unsupported SystemCapability
    }

  }
}