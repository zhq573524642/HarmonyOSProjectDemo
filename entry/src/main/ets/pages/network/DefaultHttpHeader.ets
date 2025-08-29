import { HttpHeaderInterface } from './HttpUtils';

export class DefaultHttpHeader implements HttpHeaderInterface {
  contentTypeValue: string = 'application/json'
  tokenValue: string = ''

  getHeader(): Record<string, Object> {
    let header: Record<string, Object> = {
      'Content-Type': this.contentTypeValue,
      'Authorization': this.tokenValue
    }
    return header
  }
}

let httpHeader: DefaultHttpHeader = new DefaultHttpHeader()

export default httpHeader as DefaultHttpHeader