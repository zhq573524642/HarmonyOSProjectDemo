

import { BuilderData } from "./DynamicComponent";
import { Config, configs } from "./PrecompileConfig";

@Builder
function WebBuilder(data: BuilderData) {
  Web({ src: data.url, controller: data.controller })
    .onControllerAttached(() => {
      precompile(data.controller, configs);
    })
    .fileAccess(true)
}

export const precompileWebview = wrapBuilder<BuilderData[]>(WebBuilder);

export const precompile = async (controller: WebviewController, configs: Array<Config>) => {
  for (const config of configs) {
    let content = await readRawFile(config.localPath);

    try {
      controller.precompileJavaScript(config.url, content, config.options)
        .then(errCode => {
          console.error("precompile successfully! " + errCode);
        }).catch((errCode: number) => {
        console.error("precompile failed. " + errCode);
      });
    } catch (err) {
      console.error("precompile failed. " + err.code + " " + err.message);
    }
  }
}

async function readRawFile(path: string) {
  try {
    return await getContext().resourceManager.getRawFileContent(path);;
  } catch (err) {
    return new Uint8Array(0);
  }
}