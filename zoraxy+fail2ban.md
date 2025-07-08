# Zoraxy + fail2ban

## Separation of Zoraxy Fail2ban Filters

To improve accuracy and maintainability of the automatic blocking system, Fail2ban rules were divided into two separate filters: *zoraxy-errors* and *zoraxy-auth*.

* zoraxy-errors monitors critical HTTP error codes such as 403, 429, and 444 across various endpoints, excluding static and status routes, to detect potential attacks or abuse targeting the application.

* zoraxy-auth focuses exclusively on detecting failed authentication attempts by tracking 401 responses on sensitive paths like /api/auth and /login.

This separation allows configuring different thresholds, ban durations, and specific actions for each type of incident, optimizing threat response while minimizing false positives for legitimate access.

## Files

`/etc/fail2ban/filter.d/zoraxy-auth.conf`:

```
[Definition]
failregex = \[client: <HOST>\].*POST\s(/api/auth|/login)\s401
```

`/etc/fail2ban/filter.d/zoraxy-errors.conf`:

```
[Definition]
failregex = \[client: <HOST>\].*\s(GET|POST|HEAD|PUT|DELETE|OPTIONS)\s(?!/(locales|api/users/me|api/settings/public|api/users/admin/check|api/system/status|favicon\.ico|robots\.txt|apple-touch-icon.*|api/notes)).*\s(403|429|444)
```

`/etc/fail2ban/jail.local`:

```
# /etc/fail2ban/jail.local

[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 192.168.88.0/24
bantime = 24h
findtime = 1h
maxretry = 3
backend = auto
banaction = iptables-allports
bantime.increment = true
bantime.factor = 24
bantime.maxtime = 720h

# ------------------------
# Jail para errores HTTP críticos (403, 429, 444)
[zoraxy-errors]
enabled   = true
filter    = zoraxy-errors
logpath   = /opt/zoraxy/log/*.log
maxretry  = 8
findtime  = 15m
bantime   = 1h
banaction = iptables-allports

# ------------------------
# Jail para intentos fallidos de login (401 en /api/auth o /login)
[zoraxy-auth]
enabled   = true
filter    = zoraxy-auth
logpath   = /opt/zoraxy/log/*.log
maxretry  = 3
findtime  = 15m
bantime   = 2h
banaction = iptables-allports
```
