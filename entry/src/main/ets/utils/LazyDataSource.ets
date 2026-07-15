/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
// import { ObservedArray } from './ObservedArray';


const TAG = '[BasicDataSource]';

class BasicDataSource<T> implements IDataSource {
  private listeners: DataChangeListener[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): T | undefined {
    return undefined;
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

@Observed
export default class LazyDataSource<T> extends BasicDataSource<T> {
  dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): T {
    return this.dataArray[index];
  }

  public getAllData(): T[] {
    return this.dataArray;
  }

  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  // public pushArrayData(newData: ObservedArray<T>): void {
  //   this.clear();
  //   this.dataArray.push(...newData);
  //   this.notifyDataReload();
  // }

  public pushArrayData(newData: Array<T>): void {
    this.clear();
    this.dataArray.push(...newData);
    this.notifyDataReload();
  }

  // public appendArrayData(addData: ObservedArray<T>): void {
  //   this.dataArray.push(...addData);
  //   this.notifyDataReload();
  // }

  public appendArrayData(addData: Array<T>): void {
    this.dataArray.push(...addData);
    this.notifyDataReload();
  }

  public deleteData(index: number): void {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public deleteMoreData(start: number, deleteCount: number) {
    this.dataArray.splice(start, deleteCount);
    this.notifyDataReload();
  }

  public changeData(index: number, data: T): void {
    this.dataArray.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  //交换数据
  public moveData(from: number, to: number): void {
    if ((from >= 0 && from < this.dataArray.length) && (to >= 0 && to < this.dataArray.length)) {
      let temp: T = this.dataArray[from];
      this.dataArray[from] = this.dataArray[to];
      this.dataArray[to] = temp;
      this.notifyDataMove(from, to);
    } else {
      return
    }

  }
  public moveDataWithoutNotify(from: number, to: number): void {
    let tmp = this.dataArray.splice(from, 1);
    this.dataArray.splice(to, 0, tmp[0]);
    this.notifyDataReload()
  }


  // public getDataList(): ObservedArray<T> {
  //   return this.dataArray;
  // }
  public getDataList(): Array<T> {
    return this.dataArray;
  }

  public clear(): void {
    this.dataArray.splice(0, this.dataArray?.length);
    this.notifyDataReload();
  }

  public isEmpty(): boolean {
    return this.dataArray.length === 0;
  }
}
