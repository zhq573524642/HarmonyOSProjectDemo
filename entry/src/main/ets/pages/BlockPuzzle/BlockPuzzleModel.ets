export class BlockPuzzleResponseModel {
  repCode: string = ''
  repMsg: string = ''
  repData: BlockPuzzleModel = new BlockPuzzleModel()
}

export class BlockPuzzleModel {
  originalImageBase64: string = ''
  jigsawImageBase64: string = ''
  token: string = ''
  secretKey: string = ''
  result: string = ''
  wordList: Array<string> = []
}