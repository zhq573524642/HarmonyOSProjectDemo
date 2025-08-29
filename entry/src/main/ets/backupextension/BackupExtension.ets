import BackupExtensionAbility, { BundleVersion } from '@ohos.application.BackupExtensionAbility';

class BackupExtension extends BackupExtensionAbility {
  onBackupEx(backupInfo: string): string | Promise<string> {
    return ''
  }

  onRestoreEx(bundleVersion: BundleVersion, restoreInfo: string): string | Promise<string> {
    return ''
  }
}