

export class ResponseResultC<T> {
  /**  ，0成功 */
  code: number;
  /**  数据 */
  data: T;
  /**  消息 */
  msg: string;

  timestamp: number;

  time: string;

  constructor(code: number, data: T, msg: string,timestamp: number,time:string) {
    this.code = code;
    this.data = data;
    this.msg = msg;
    this.timestamp = timestamp;
    this.time = time;
  }
}