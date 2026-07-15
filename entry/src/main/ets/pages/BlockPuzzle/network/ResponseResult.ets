export class ResponseResult<T> {
  /**  ，1成功 */
  state: number;
  /**  数据 */
  data: T;
  /**  消息 */
  msg: string;

  constructor(state: number, data: T, msg: string) {
    this.state = state;
    this.data = data;
    this.msg = msg;
  }
}

export class ResponseResultB<T> {
  /**  ，1成功 */
  status: number;
  /**  数据 */
  data: T;
  /**  消息 */
  message: string;
  ts: string;

  constructor(status: number, data: T, message: string, ts: string) {
    this.status = status;
    this.data = data;
    this.message = message;
    this.ts = ts;
  }
}

export class ResponseResultC<T> {
  /**  ，0成功 */
  code: number;
  /**  数据 */
  data: T;
  /**  消息 */
  msg: string;
  timestamp: number;
  time: string;
  /**  停服埋点 ==1 */
  disable?: number;

  constructor(code: number, data: T, msg: string, timestamp: number, time: string, disable?: number) {
    this.code = code;
    this.data = data;
    this.msg = msg;
    this.timestamp = timestamp;
    this.time = time;
    this.disable = disable;
  }
}

export class ResponseResultD<T> {
  /**  ，0成功 */
  code: number;
  /**  消息 */
  msg: string;
  data: T
  success: boolean;

  constructor(code: number, msg: string, success: boolean, data: T) {
    this.code = code;
    this.msg = msg;
    this.success = success;
    this.data = data;
  }
}

export class ResponseResultE<T> {
  /**  ，数据 */
  list: T;
  //2026.3.12 14:20 新增字段：学员是否确认过信息  0未确认 1确认过
  isConfirmInfo: number = 0

  constructor(list: T) {
    this.list = list;
  }
}

export class ResponseResultF<T> {
  /**  ，数据 */
  projectList: T;

  constructor(projectList: T) {
    this.projectList = projectList;
  }
}

export class ResponseResultG {
  /**  ，1成功 */
  state: number;
  /**  消息 */
  info: string;
  code: string

  constructor(state: number, msg: string, code: string) {
    this.state = state;
    this.info = msg;
    this.code = code;
  }
}

export class ResponseResultH {
  /**  ，1成功 */
  status: number;
  /**  消息 */
  info: string;
  code: string
  msg: string

  constructor(status: number, info: string, code: string, msg: string) {
    this.status = status;
    this.info = info;
    this.code = code;
    this.msg = msg;
  }
}

export class ResponseResultJ {
  /**  ，1成功 */
  state: string;
  /**  消息 */
  info: string;
  code: string;
  success: boolean;

  constructor(state: string, msg: string, code: string, success: boolean) {
    this.state = state;
    this.info = msg;
    this.code = code;
    this.success = success;
  }
}

export class ResponseResultK<T> {
  data: T;

  constructor(data: T) {
    this.data = data;
  }
}

export class ResponseResultP<T> {
  /**  ，1成功 */
  status: number;
  /**  数据 */
  data: T;
  /**  消息 */
  total: string;
  msg: string;

  constructor(status: number, data: T, total: string, msg: string) {
    this.status = status;
    this.data = data;
    this.msg = msg;
    this.total = total;
  }
}