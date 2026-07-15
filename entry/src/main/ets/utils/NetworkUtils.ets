import { connection } from "@kit.NetworkKit";

export class NetworkUtils {
  netConnection: connection.NetConnection | null = null;

  registerNetworkChangeListener() {
    this.netConnection = connection.createNetConnection()

  }
}