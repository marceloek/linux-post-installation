# This folder contain `autounattend.xml` script files for Windows 10/11 before/after installations

## All the script files are generated from [Generate autounattend.xml files for Windows 10/11](https://schneegans.de/windows/unattend-generator/)

## Observations
- Script files containing `wipe_on` will FORMAT ALL DATA on `SELECT DISK 0` in `diskpart.exe` when loaded; if you don't want this, use scripts containing `wipe_off`;
- Script files containing `tpm_on` will NOT IGNORE Windows 11 requirements (RAM, TPM, Secure Boot) when loaded; if you don't want this, use scripts containing `tpm_on`;
- 
