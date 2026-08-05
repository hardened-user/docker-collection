#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
if [[ $# -gt 0 ]]; then
  # overriding cmd (example: docker run image /bin/bash)
  exec "$@"
fi

# ----------------------------------------------------------------------------------------------------------------------
del_config() {
  sed -i -E "/^[[:space:]]*$1[[:space:]]/d" "${TINYPROXY_CONFIG_FILE}"
}

unquote() {
  local s="$1"
  s="${s#\"}"
  s="${s%\"}"
  printf '%s' "${s}"
}

trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "${s}"
}

set_simple() {
  local param="$1" value="$2"
  value="$(unquote "$value")"
  del_config "${param}"
  printf '%s %s\n' "${param}" "${value}" >> "${TINYPROXY_CONFIG_FILE}"
}

set_quoted() {
  local param="$1" value="$2"
  value="$(unquote "$value")"
  del_config "${param}"
  printf '%s "%s"\n' "${param}" "${value}" >> "${TINYPROXY_CONFIG_FILE}"
}

set_multiple() {
  local param="$1" v="$2"
  local -a items=()
  IFS=',' read -r -a items <<< "$2"
  del_config "${param}"
  for v in ${items[@]+"${items[@]}"}; do
    v="$(trim "${v}")"
    [[ -z "${v}" ]] && continue
    printf '%s %s\n' "${param}" "${v}" >> "${TINYPROXY_CONFIG_FILE}"
  done
}

# ----------------------------------------------------------------------------------------------------------------------
[[ -n "${TINYPROXY_USER:-}"                ]] && set_simple   "User"                "${TINYPROXY_USER}"
[[ -n "${TINYPROXY_GROUP:-}"               ]] && set_simple   "Group"               "${TINYPROXY_GROUP}"
[[ -n "${TINYPROXY_PORT:-}"                ]] && set_simple   "Port"                "${TINYPROXY_PORT}"
[[ -n "${TINYPROXY_LISTEN:-}"              ]] && set_simple   "Listen"              "${TINYPROXY_LISTEN}"
[[ -n "${TINYPROXY_BIND:-}"                ]] && set_simple   "Bind"                "${TINYPROXY_BIND}"
[[ -n "${TINYPROXY_BINDSAME:-}"            ]] && set_simple   "BindSame"            "${TINYPROXY_BINDSAME}"
[[ -n "${TINYPROXY_TIMEOUT:-}"             ]] && set_simple   "Timeout"             "${TINYPROXY_TIMEOUT}"
[[ -n "${TINYPROXY_STATHOST:-}"            ]] && set_quoted   "StatHost"            "${TINYPROXY_STATHOST}"
[[ -n "${TINYPROXY_LOGFILE:-}"             ]] && set_quoted   "LogFile"             "${TINYPROXY_LOGFILE}"
[[ -n "${TINYPROXY_SYSLOG:-}"              ]] && set_simple   "Syslog"              "${TINYPROXY_SYSLOG}"
[[ -n "${TINYPROXY_LOGLEVEL:-}"            ]] && set_simple   "LogLevel"            "${TINYPROXY_LOGLEVEL}"
[[ -n "${TINYPROXY_PIDFILE:-}"             ]] && set_quoted   "PidFile"             "${TINYPROXY_PIDFILE}"
[[ -n "${TINYPROXY_XTINYPROXY:-}"          ]] && set_simple   "XTinyproxy"          "${TINYPROXY_XTINYPROXY}"
[[ -n "${TINYPROXY_UPSTREAM:-}"            ]] && set_multiple "Upstream"            "${TINYPROXY_UPSTREAM}"
[[ -n "${TINYPROXY_MAXCLIENTS:-}"          ]] && set_simple   "MaxClients"          "${TINYPROXY_MAXCLIENTS}"
[[ -n "${TINYPROXY_ALLOW:-}"               ]] && set_multiple "Allow"               "${TINYPROXY_ALLOW}"
[[ -n "${TINYPROXY_DENY:-}"                ]] && set_multiple "Deny"                "${TINYPROXY_DENY}"

if [[ -n "${TINYPROXY_BASICAUTH_USER:-}" && -n "${TINYPROXY_BASICAUTH_PASS:-}" ]]; then
  set_simple "BasicAuth" "${TINYPROXY_BASICAUTH_USER} ${TINYPROXY_BASICAUTH_PASS}"
fi

[[ -n "${TINYPROXY_VIAPROXYNAME:-}"        ]] && set_quoted   "ViaProxyName"        "${TINYPROXY_VIAPROXYNAME}"
[[ -n "${TINYPROXY_DISABLEVIAHEADER:-}"    ]] && set_simple   "DisableViaHeader"    "${TINYPROXY_DISABLEVIAHEADER}"
[[ -n "${TINYPROXY_FILTER:-}"              ]] && set_quoted   "Filter"              "${TINYPROXY_FILTER}"
[[ -n "${TINYPROXY_FILTERURLS:-}"          ]] && set_simple   "FilterURLs"          "${TINYPROXY_FILTERURLS}"
[[ -n "${TINYPROXY_FILTERTYPE:-}"          ]] && set_simple   "FilterType"          "${TINYPROXY_FILTERTYPE}"
[[ -n "${TINYPROXY_FILTERCASESENSITIVE:-}" ]] && set_simple   "FilterCaseSensitive" "${TINYPROXY_FILTERCASESENSITIVE}"
[[ -n "${TINYPROXY_FILTERDEFAULTDENY:-}"   ]] && set_simple   "FilterDefaultDeny"   "${TINYPROXY_FILTERDEFAULTDENY}"
[[ -n "${TINYPROXY_ANONYMOUS:-}"           ]] && set_multiple "Anonymous"           "${TINYPROXY_ANONYMOUS}"
[[ -n "${TINYPROXY_CONNECTPORT:-}"         ]] && set_multiple "ConnectPort"         "${TINYPROXY_CONNECTPORT}"
[[ -n "${TINYPROXY_REVERSEPATH:-}"         ]] && set_multiple "ReversePath"         "${TINYPROXY_REVERSEPATH}"
[[ -n "${TINYPROXY_REVERSEONLY:-}"         ]] && set_simple   "ReverseOnly"         "${TINYPROXY_REVERSEONLY}"
[[ -n "${TINYPROXY_REVERSEMAGIC:-}"        ]] && set_simple   "ReverseMagic"        "${TINYPROXY_REVERSEMAGIC}"
[[ -n "${TINYPROXY_REVERSEBASEURL:-}"      ]] && set_quoted   "ReverseBaseURL"      "${TINYPROXY_REVERSEBASEURL}"

# ----------------------------------------------------------------------------------------------------------------------
exec /usr/bin/tinyproxy -d -c "${TINYPROXY_CONFIG_FILE}"
