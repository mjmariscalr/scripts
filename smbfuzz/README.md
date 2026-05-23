# SMBfuzz

Script en Bash para enumerar recursos compartidos SMB en un host objetivo utilizando autenticación anónima.

## Descripción

Este script realiza descubrimiento básico de recursos SMB contra una dirección IP o dominio. Lee posibles nombres de recursos compartidos desde un diccionario y comprueba si cada recurso:

- Existe y es accesible
- Existe pero el acceso está denegado
- No existe

## Características

- Enumeración de recursos SMB
- Autenticación anónima
- Descubrimiento basado en wordlists

## Requisitos

Es necesario tener instaladas las siguientes herramientas:

- `nc`
- `smbclient`

## Uso

```bash
bash smbfuzz.sh -o <objetivo> -s <wordlist>
```

Opciones:

| Opción | Descripción |
|---|---|
| -o | Dirección IP o dominio objetivo |
| -s | Wordlist con nombres de recursos compartidos |
| -h | Mostrar mensaje de ayuda |
| -v | Mostrar versión del script |

Ejemplo

```bash
bash smb_enum.sh -o 192.168.1.10 -s shares.txt
[+] FOUND: public
[!] NO ACCESS: finance
[-] NOT FOUND: backup
Scan complete: 1 host scanned, 1 shares found.
```

---

## Notas
Pensado para fines educativos, laboratorios y auditorías autorizadas. No la utilices contra sistemas sin permiso explícito.
